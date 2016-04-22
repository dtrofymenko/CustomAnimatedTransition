//
//  AdvancedTransitionAnimator.swift
//  CustomAnimatedTransition
//
//  Created by Dmytro Trofymenko on 4/18/16.
//  Copyright © 2016 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class AdvancedTransitionAnimator : NSObject, UIViewControllerAnimatedTransitioning {
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
      if let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? ModalViewController,
         let fromVC = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as?
            UINavigationController)?.viewControllers.first as?
            ViewController,
         let toView = transitionContext.viewForKey(UITransitionContextToViewKey),
         let containerView = transitionContext.containerView()
         {
         
         toView.frame = transitionContext.finalFrameForViewController(toVC)
         containerView.addSubview(toView)
         
         let tableViewCell = fromVC.tableView.cellForRowAtIndexPath(fromVC.tableView.indexPathForSelectedRow!) as!
            TableViewCell
         let transitionImageView = UIImageView.init(image: tableViewCell.avatarView.image)
         transitionImageView.contentMode = .ScaleAspectFill
         transitionImageView.clipsToBounds = true
         transitionImageView.frame = containerView.convertRect(tableViewCell.avatarView.bounds,
            fromView: tableViewCell.avatarView)
         containerView.addSubview(transitionImageView)

         let cornerRadius = CGRectGetWidth(transitionImageView.frame) / 2
         tableViewCell.avatarView.alpha = 0.0
         toVC.imageView.alpha = 0.0;
         toView.alpha = 0.0;
         
         UIView.animateWithDuration(self.transitionDuration(transitionContext),
            animations: {
               transitionImageView.frame = containerView.convertRect(toVC.imageView.bounds, fromView: toVC.imageView)
               toView.alpha = 1.0;
            },
            completion: { (finished: Bool) in
               transitionImageView.removeFromSuperview()
               tableViewCell.avatarView.alpha = 1.0
               toVC.imageView.alpha = 1.0;
               transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
         )
         
         let cornerRadiusAnimation = CABasicAnimation.init()
         cornerRadiusAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
         cornerRadiusAnimation.fromValue = cornerRadius
         cornerRadiusAnimation.toValue = 0.0
         cornerRadiusAnimation.keyPath = "cornerRadius"
         cornerRadiusAnimation.duration = transitionDuration(transitionContext)
         cornerRadiusAnimation.removedOnCompletion = true
         transitionImageView.layer.addAnimation(cornerRadiusAnimation, forKey: nil)
      } else {
         transitionContext.completeTransition(false)
      }
   }

   private func animateDismissalTransition(transitionContext: UIViewControllerContextTransitioning) {
      if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? ModalViewController,
         let toVC = (transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as?
            UINavigationController)?.viewControllers.first as?
            ViewController,
         let toView = transitionContext.viewForKey(UITransitionContextToViewKey),
         let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey),
         let containerView = transitionContext.containerView()
         {
         
         toView.frame = transitionContext.finalFrameForViewController(
            transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
         containerView.insertSubview(toView, belowSubview: fromView)
         

         let transitionImageView = UIImageView.init(image: fromVC.imageView.image)
         transitionImageView.contentMode = .ScaleAspectFill
         transitionImageView.clipsToBounds = true
         transitionImageView.frame = containerView.convertRect(fromVC.imageView.bounds,
            fromView: fromVC.imageView)
         containerView.addSubview(transitionImageView)

         let tableViewCell = toVC.tableView.cellForRowAtIndexPath(toVC.selectedIndexPath!) as!
                     TableViewCell
         tableViewCell.avatarView.alpha = 0.0
         fromVC.imageView.alpha = 0.0;
            
         UIView.animateWithDuration(self.transitionDuration(transitionContext),
            animations: {
               fromView.alpha = 0.0;
               transitionImageView.frame = containerView.convertRect(tableViewCell.avatarView.bounds,
                           fromView: tableViewCell.avatarView)
            },
            completion: { (finished: Bool) in
               transitionImageView.removeFromSuperview()
               tableViewCell.avatarView.alpha = 1.0
               fromVC.imageView.alpha = 1.0;
               
               transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
         )

         transitionImageView.layer.cornerRadius = CGRectGetWidth(transitionImageView.frame) / 2
         
         let cornerRadiusAnimation = CABasicAnimation.init()
         cornerRadiusAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
         cornerRadiusAnimation.fromValue = 0.0
         cornerRadiusAnimation.toValue = CGRectGetWidth(transitionImageView.frame) / 2
         cornerRadiusAnimation.keyPath = "cornerRadius"
         cornerRadiusAnimation.duration = transitionDuration(transitionContext)
         cornerRadiusAnimation.removedOnCompletion = true
         transitionImageView.layer.addAnimation(cornerRadiusAnimation, forKey: nil)
         
      } else {
         transitionContext.completeTransition(false)
      }
   }
}

