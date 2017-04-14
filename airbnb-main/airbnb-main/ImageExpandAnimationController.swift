//
//  ImageExpandAnimationController.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 10/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

protocol ImageExpandAnimationControllerProtocol {
    func getImageDestinationFrame() -> CGRect
}

class ImageExpandAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            toVC is ImageExpandAnimationControllerProtocol else {
                return
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let containerView = transitionContext.containerView
        containerView.backgroundColor = UIColor.white
        containerView.addSubview(toVC.view)
        
        // setup cell image snapshot
        let initialFrame = originFrame
        let finalFrame = (toVC as! ImageExpandAnimationControllerProtocol).getImageDestinationFrame()
        let snapshot = toVC.view.resizableSnapshotView(from: finalFrame, afterScreenUpdates: true, withCapInsets: .zero)!
        snapshot.frame = initialFrame
        
        containerView.addSubview(snapshot)
        
        let widthDiff = finalFrame.width - initialFrame.width
        
        // setup snapshot to the left of selected cell image
        let leftInitialFrame = CGRect(x: 0, y: initialFrame.origin.y, width: initialFrame.origin.x, height: initialFrame.height)
        let leftFinalFrameWidth = leftInitialFrame.width + widthDiff
        let leftFinalFrame = CGRect(x: finalFrame.origin.x - leftFinalFrameWidth, y: finalFrame.origin.y, width: leftFinalFrameWidth, height: finalFrame.height)
        let leftSnapshot = fromVC.view.resizableSnapshotView(from: leftInitialFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        leftSnapshot.frame = leftInitialFrame
        
        containerView.addSubview(leftSnapshot)
        
        // setup snapshot to the right of selected cell image
        let rightInitialFrameX = initialFrame.origin.x + initialFrame.width
        let rightInitialFrame = CGRect(x: rightInitialFrameX, y: initialFrame.origin.y, width: screenWidth - rightInitialFrameX, height: initialFrame.height)
        let rightFinalFrame = CGRect(x: screenWidth, y: finalFrame.origin.y, width: rightInitialFrame.width + widthDiff, height: finalFrame.height)
        let rightSnapshot = fromVC.view.resizableSnapshotView(from: rightInitialFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        rightSnapshot.frame = rightInitialFrame
 
        containerView.addSubview(rightSnapshot)
        
        // setup snapshot to the bottom of selected cell image
        let bottomInitialFrameY = initialFrame.origin.y + initialFrame.height
        let bottomInitialFrame = CGRect(x: 0, y: bottomInitialFrameY, width: screenWidth, height: screenHeight - bottomInitialFrameY)
        let bottomFinalFrame = CGRect(x: 0, y: screenHeight, width: bottomInitialFrame.width, height: bottomInitialFrame.height)
        let bottomSnapshot = fromVC.view.resizableSnapshotView(from: bottomInitialFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        bottomSnapshot.frame = bottomInitialFrame
        
        containerView.addSubview(bottomSnapshot)
        
        // setup snapshot to the top of selected cell image
        let topInitialFrame = CGRect(x: 0, y: 0, width: screenWidth, height: initialFrame.origin.y)
        let topFinalFrame = CGRect(x: 0, y: -topInitialFrame.height, width: topInitialFrame.width, height: topInitialFrame.height)
        let topSnapshot = fromVC.view.resizableSnapshotView(from: topInitialFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        topSnapshot.frame = topInitialFrame
        
        containerView.addSubview(topSnapshot)
        
        // setup the bottom component of the destination view
        let toVCBottomFinalFrameY = finalFrame.origin.y + finalFrame.height
        let toVCBottomFinalFrame = CGRect(x: 0, y: toVCBottomFinalFrameY, width: screenWidth, height: screenHeight - toVCBottomFinalFrameY)
        let toVCBottomInitialFrame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: toVCBottomFinalFrame.height)
        let toVCBottomSnapshot = toVC.view.resizableSnapshotView(from: toVCBottomFinalFrame, afterScreenUpdates: true, withCapInsets: .zero)!
        toVCBottomSnapshot.frame = toVCBottomInitialFrame
       
        containerView.addSubview(toVCBottomSnapshot)

        fromVC.view.isHidden = true
        toVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
            
            snapshot.frame = finalFrame
            leftSnapshot.frame = leftFinalFrame
            rightSnapshot.frame = rightFinalFrame
            bottomSnapshot.frame = bottomFinalFrame
            topSnapshot.frame = topFinalFrame
            toVCBottomSnapshot.frame = toVCBottomFinalFrame
            
        }, completion: { _ in
            
            toVC.view.isHidden = false
            fromVC.view.isHidden = false
            
            snapshot.removeFromSuperview()
            leftSnapshot.removeFromSuperview()
            rightSnapshot.removeFromSuperview()
            bottomSnapshot.removeFromSuperview()
            topSnapshot.removeFromSuperview()
            toVCBottomSnapshot.removeFromSuperview()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
        })
    }
}
