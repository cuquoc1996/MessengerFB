//
//  HalfWidthAnimator.swift
//  MessengerFB
//
//  Created by MacBook Pro on 07/10/2025.
//

import UIKit

class HalfWidthAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let isPresenting: Bool
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let key: UITransitionContextViewControllerKey = isPresenting ? .to : .from
        guard let vc = transitionContext.viewController(forKey: key) else { return }
        
        let finalFrame = transitionContext.finalFrame(for: vc)
        var startFrame = finalFrame
        
        if isPresenting {
            startFrame.origin.x = container.bounds.width
            vc.view.frame = startFrame
            container.addSubview(vc.view)
        }
        
        let endFrame = isPresenting
        ? finalFrame
        : CGRect(x: container.bounds.width, y: 0, width: finalFrame.width, height: finalFrame.height)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0,
                       usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            vc.view.frame = endFrame
        }) { finished in
            if !self.isPresenting {
                vc.view.removeFromSuperview()
            }
            transitionContext.completeTransition(finished)
        }
    }
}
