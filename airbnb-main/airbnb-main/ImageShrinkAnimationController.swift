//
//  ImageShrinkAnimationController.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 11/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

protocol ImageShrinkAnimationControllerProtocol {
    func getInitialImageFrame() -> CGRect
}

class ImageShrinkAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
 
    var destinationFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            fromVC is ImageShrinkAnimationControllerProtocol,
            let toVC = transitionContext.viewController(forKey: .to) else {
                return
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let containerView = transitionContext.containerView
        containerView.backgroundColor = UIColor.white
        containerView.addSubview(toVC.view)
        
        // setup cell image snapshot
        let initialFrame = (fromVC as! ImageShrinkAnimationControllerProtocol).getInitialImageFrame()
        let finalFrame = destinationFrame
        let snapshot = fromVC.view.resizableSnapshotView(from: initialFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        snapshot.frame = initialFrame
        containerView.addSubview(snapshot)
        
        let widthDiff = initialFrame.width - finalFrame.width
        
        // setup snapshot to the left of selected cell image
        let leftFinalFrame = CGRect(x: 0, y: finalFrame.origin.y, width: finalFrame.origin.x, height: finalFrame.height)
        let leftInitialFrameWidth = leftFinalFrame.width + widthDiff
        let leftInitialFrame = CGRect(x: -leftInitialFrameWidth, y: initialFrame.origin.y, width: leftInitialFrameWidth, height: initialFrame.height)
        let leftSnapshot = toVC.view.resizableSnapshotView(from: leftFinalFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        leftSnapshot.frame = leftInitialFrame
        
        containerView.addSubview(leftSnapshot)

        // setup snapshot to the right of selected cell image
        let rightFinalFrameX = finalFrame.origin.x + finalFrame.width
        let rightFinalFrame = CGRect(x: rightFinalFrameX, y: finalFrame.origin.y, width: screenWidth - rightFinalFrameX, height: finalFrame.height)
        let rightInitialFrame = CGRect(x: screenWidth, y: initialFrame.origin.y, width: rightFinalFrame.width + widthDiff, height: initialFrame.height)
        let rightSnapshot = toVC.view.resizableSnapshotView(from: rightFinalFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        rightSnapshot.frame = rightInitialFrame
        
        containerView.addSubview(rightSnapshot)
        
        // setup snapshot to the bottom of selected cell image
        let bottomFinalFrameY = finalFrame.origin.y + finalFrame.height
        let bottomFinalFrame = CGRect(x: 0, y: bottomFinalFrameY, width: screenWidth, height: screenHeight - bottomFinalFrameY)
        let bottomInitialFrame = CGRect(x: 0, y: bottomFinalFrame.height, width: screenWidth, height: screenHeight)
        let bottomSnapshot = toVC.view.resizableSnapshotView(from: bottomFinalFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        bottomSnapshot.frame = bottomInitialFrame
        
        containerView.addSubview(bottomSnapshot)

        // setup snapshot to the top of selected cell image
        let topFinalFrame = CGRect(x: 0, y: 0, width: screenWidth, height: finalFrame.origin.y)
        let topInitialFrame = CGRect(x: 0, y: -topFinalFrame.height, width: topFinalFrame.width, height: topFinalFrame.height)
        let topSnapshot = toVC.view.resizableSnapshotView(from: topFinalFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        topSnapshot.frame = topInitialFrame
        
        containerView.addSubview(topSnapshot)
        
        
        // setup the bottom component of the origin view
        let fromVCBottomInitialFrameY = initialFrame.origin.y + initialFrame.height
        let fromVCBottomInitialFrame = CGRect(x: 0, y: fromVCBottomInitialFrameY, width: screenWidth, height: screenHeight - fromVCBottomInitialFrameY)
        let fromVCBottomFinalFrame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: fromVCBottomInitialFrame.height)
        let fromVCSnapshot = fromVC.view.resizableSnapshotView(from: fromVCBottomInitialFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        fromVCSnapshot.frame = fromVCBottomInitialFrame
        
        containerView.addSubview(fromVCSnapshot)
        
        toVC.view.isHidden = true
        fromVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: 0.3, animations: {
            //fromVCSnapshot.alpha = 0
            fromVCSnapshot.frame = fromVCBottomFinalFrame

        }, completion: { _ in
            
            fromVCSnapshot.removeFromSuperview()
        })
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
            
            snapshot.frame = finalFrame
            leftSnapshot.frame = leftFinalFrame
            rightSnapshot.frame = rightFinalFrame
            bottomSnapshot.frame = bottomFinalFrame
            topSnapshot.frame = topFinalFrame
            
        }, completion: { _ in
         
            toVC.view.isHidden = false
            fromVC.view.isHidden = false
            
            snapshot.removeFromSuperview()
            leftSnapshot.removeFromSuperview()
            rightSnapshot.removeFromSuperview()
            bottomSnapshot.removeFromSuperview()
            topSnapshot.removeFromSuperview()

            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
