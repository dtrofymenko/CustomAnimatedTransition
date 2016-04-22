//
//  TransitionAnimator.swift
//  CustomAnimatedTransition
//
//  Created by Dmytro Trofymenko on 4/12/16.
//  Copyright © 2016 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class SimpleTransitionAnimator : NSObject, UIViewControllerAnimatedTransitioning {

   var isPresentationTransition: Bool
   
   override init() {
      isPresentationTransition = true
      super.init()
   }
   
   func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
      return 0.25;
   }
   
   func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
      if (isPresentationTransition) {
         animatePresentationTransition(transitionContext)
      } else {
         animateDismissalTransition(transitionContext)
      }
   }

   private func animatePresentationTransition(transitionContext: UIViewControllerContextTransitioning) {
      // 1. Obtain transition context values
      if let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
         let toView = transitionContext.viewForKey(UITransitionContextToViewKey) {

         // 2. Set initial values
         toView.frame = transitionContext.finalFrameForViewController(toVC)
         toView.transform = CGAffineTransformMakeScale(0.8, 0.8);
         toView.alpha = 0.0;
         
         transitionContext.containerView()?.addSubview(toView)
         
         UIView.animateWithDuration(self.transitionDuration(transitionContext),
            animations: {
               // 3. Animate final values
               toView.transform = CGAffineTransformIdentity
               toView.alpha = 1.0;
            },
            completion: { (finished: Bool) in
               // 4. Reset to original values
               // 5. Complete transition
               transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
         )
         
      } else {
         transitionContext.completeTransition(false)
      }
   }

   private func animateDismissalTransition(transitionContext: UIViewControllerContextTransitioning) {
      // 1. Obtain transition context values
      if let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) {
         
         if let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey) {
            // 2. Set initial values
            toView.frame = transitionContext.finalFrameForViewController(toVC)
            transitionContext.containerView()?.insertSubview(toView, belowSubview: fromView)
         }
         
         UIView.animateWithDuration(self.transitionDuration(transitionContext),
            animations: {
               // 3. Animate final values
               fromView.transform = CGAffineTransformMakeScale(0.8, 0.8);
               fromView.alpha = 0.0;
            },
            completion: { (finished: Bool) in
               // 4. Reset to original values
               // 5. Complete transition
               transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
         )
      } else {
         transitionContext.completeTransition(false)
      }
   }
}
