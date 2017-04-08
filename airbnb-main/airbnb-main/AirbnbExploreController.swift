//
//  AirbnbExploreController.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 11/3/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class AirbnbExploreController: UIViewController {
    
    var currentPageController: UIViewController?
    var isFirstAppear: Bool = true
    var minHeaderHeight: CGFloat {
        return headerView.minHeaderHeight
    }
    var midHeaderHeight: CGFloat {
        return headerView.midHeaderHeight
    }
    var maxHeaderHeight: CGFloat {
        return headerView.maxHeaderHeight
    }
    var headerViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: - View Components
    
    lazy var headerView: AirbnbExploreHeaderView = {
        let view = AirbnbExploreHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.pageTabDelegate = self
        return view
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var feedController: AirbnbExploreFeedController = {
        let controller = AirbnbExploreFeedController()
        controller.title = "For You"
        return controller
    }()
    
    var homeController: AirbnbExploreHomeController = {
        let controller = AirbnbExploreHomeController()
        controller.title = "Homes"
        return controller
    }()
    
    var experienceController: AirbnbExploreHomeController = {
        let controller = AirbnbExploreHomeController()
        controller.title = "Experience"
        return controller
    }()
    
    var placeController: AirbnbExploreHomeController = {
        let controller = AirbnbExploreHomeController()
        controller.title = "Places"
        return controller
    }()
    
    // MARK: - View Setups
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        headerView.pageTabControllers = [feedController, homeController, experienceController, placeController]
        
        setContent(toViewControllerAtIndex: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFirstAppear {
            headerViewHeightConstraint?.constant = maxHeaderHeight
            isFirstAppear = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        currentPageController?.viewWillDisappear(animated)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return currentPageController?.preferredStatusBarUpdateAnimation ?? .fade
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentPageController?.preferredStatusBarStyle ?? .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return currentPageController?.prefersStatusBarHidden ?? false
    }
    
    func setupViews() {
        setupHeaderView()
        setupContentView()
    }
    
    func setupHeaderView() {
        view.addSubview(headerView)
        
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: maxHeaderHeight)
        headerViewHeightConstraint?.isActive = true
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    func setupContentView() {
        view.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension AirbnbExploreController: BaseTableControllerDelegate {
    func layoutViews() {
        view.layoutIfNeeded()
    }
    
    func updateStatusBar() {
        if let parent = tabBarController {
            parent.setNeedsStatusBarAppearanceUpdate()
        } else {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}

extension AirbnbExploreController: AirbnbExploreHeaderViewDelegate {
    
    func didSelect(viewController: UIViewController, completion: (() -> Void)?) {
        setContent(toViewController: viewController, completion: completion)
    }
    
    func setContent(toViewController viewController: UIViewController, completion: (() -> Void)?) {
        if currentPageController != viewController {
            
            let content = viewController.view!
            
            if currentPageController != nil {
                currentPageController!.removeFromParentViewController()
                currentPageController!.view.removeFromSuperview()
                currentPageController!.willMove(toParentViewController: nil)
            }
            
            currentPageController = viewController
            
            addChildViewController(viewController)
            contentView.addSubview(content)
            viewController.didMove(toParentViewController: self)
            
            content.translatesAutoresizingMaskIntoConstraints = false
            content.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            content.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            content.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
            content.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
            
        }
        
        if let handler = completion {
            handler()
        }
    }
    
    func setContent(toViewControllerAtIndex index: Int) {
        if  index >= 0, index < headerView.pageTabControllers.count {
            let vc = headerView.pageTabControllers[index]
            
            setContent(toViewController: vc) {
                self.headerView.animatePageTabSelection(toIndex: index)
            }
        }
    }
    
    func didCollapseHeader(completion: (() -> Void)?) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            let oldHeight = self.headerView.frame.size.height
            self.headerViewHeightConstraint?.constant = self.midHeaderHeight
            self.headerView.updateHeader(newHeight: self.midHeaderHeight, offset: self.midHeaderHeight - oldHeight)
            self.view.layoutIfNeeded()
        })
    }
    
    func didExpandHeader(completion: (() -> Void)?) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            let oldHeight = self.headerView.frame.size.height
            self.headerViewHeightConstraint?.constant = self.maxHeaderHeight
            self.headerView.updateHeader(newHeight: self.maxHeaderHeight, offset: self.maxHeaderHeight - oldHeight)
            self.view.layoutIfNeeded()
        })
    }
}



