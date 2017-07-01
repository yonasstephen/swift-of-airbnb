//
//  BaseTableController.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 13/3/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

protocol BaseTableControllerDelegate {
    var headerViewHeightConstraint: NSLayoutConstraint? { get set }
    var headerView: AirbnbExploreHeaderView { get set }
    var maxHeaderHeight: CGFloat { get }
    var midHeaderHeight: CGFloat { get }
    var minHeaderHeight: CGFloat { get }

    func layoutViews()
    func updateStatusBar()
}

class BaseTableController: UIViewController {
    var headerDelegate: BaseTableControllerDelegate!
    var previousScrollOffset: CGFloat = 0
    
    var isHiddenStatusBar: Bool = false
    var statusBarStyle: UIStatusBarStyle = .lightContent
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if let del = parent as? BaseTableControllerDelegate {
            self.headerDelegate = del
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHiddenStatusBar
    }
    
    func setStatusBarHidden(_ isHidden: Bool, withStyle style: UIStatusBarStyle) {
        if isHidden != isHiddenStatusBar || statusBarStyle != style {
            statusBarStyle = style
            isHiddenStatusBar = isHidden

            UIView.animate(withDuration: 0.5, animations: {
                self.headerDelegate.updateStatusBar()
            })
        }
    }
    
    func updateStatusBar() {
        let curHeight = headerDelegate.headerViewHeightConstraint!.constant
        if curHeight == headerDelegate.minHeaderHeight {
            setStatusBarHidden(false, withStyle: .default)
        } else if curHeight > headerDelegate.minHeaderHeight, curHeight < headerDelegate.midHeaderHeight {
            setStatusBarHidden(true, withStyle: .lightContent)
        } else {
            setStatusBarHidden(false, withStyle: .lightContent)
        }
    }
}

extension BaseTableController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let absoluteTop: CGFloat = 0
        let absoluteBottom: CGFloat = max(0, scrollView.contentSize.height - scrollView.frame.height)
        
        let scrollDif = scrollView.contentOffset.y - previousScrollOffset
        let isScrollUp = scrollDif < 0 && scrollView.contentOffset.y < absoluteBottom   // swipe down - header expands
        let isScrollDown = scrollDif > 0 && scrollView.contentOffset.y > absoluteTop    // swipe up - header shrinks
        
        var newHeight = headerDelegate.headerViewHeightConstraint!.constant
        if isScrollUp {
            newHeight = min(headerDelegate.maxHeaderHeight, (headerDelegate.headerViewHeightConstraint!.constant + abs(scrollDif)))
        } else if isScrollDown {
            newHeight = max(headerDelegate.minHeaderHeight, (headerDelegate.headerViewHeightConstraint!.constant - abs(scrollDif)))
        }
        
        if newHeight != headerDelegate.headerViewHeightConstraint!.constant {
            headerDelegate.headerViewHeightConstraint?.constant = newHeight
            headerDelegate.headerView.updateHeader(newHeight: newHeight, offset: scrollDif)
            setScrollPosition(scrollView, toPosition: previousScrollOffset)
            updateStatusBar()
        }
        
        previousScrollOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidStopScrolling(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidStopScrolling(scrollView)
        }
    }
    
    func setScrollPosition(_ scrollView: UIScrollView, toPosition position: CGFloat) {
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: position)
    }
    
    func scrollViewDidStopScrolling(_ scrollView: UIScrollView) {
        let curHeight = headerDelegate.headerViewHeightConstraint!.constant
        if curHeight < headerDelegate.midHeaderHeight {
            setHeaderHeight(scrollView, height: headerDelegate.minHeaderHeight)
        } else if curHeight < headerDelegate.maxHeaderHeight - headerDelegate.headerView.headerInputHeight {
            setHeaderHeight(scrollView, height: headerDelegate.midHeaderHeight)
        } else {
            setHeaderHeight(scrollView, height: headerDelegate.maxHeaderHeight)
        }
        
        updateStatusBar()
    }
    
    func setHeaderHeight(_ scrollView: UIScrollView, height: CGFloat) {
        self.headerDelegate.layoutViews()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerDelegate.headerViewHeightConstraint?.constant = height
            self.headerDelegate.headerView.updateHeader(newHeight: height, offset: scrollView.contentOffset.y - self.previousScrollOffset)
            self.headerDelegate.layoutViews()
        })
    }
}
