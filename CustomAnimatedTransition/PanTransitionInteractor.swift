//
//  TransitionInteractor.swift
//  CustomAnimatedTransition
//
//  Created by Dmytro Trofymenko on 4/14/16.
//  Copyright © 2016 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class PanTransitionInteractor: UIPercentDrivenInteractiveTransition {
   let gestureRecognizer : UIPanGestureRecognizer
   var isActive : Bool = false
   var startBlock : (() -> ())?
   
   override init() {
      gestureRecognizer = UIPanGestureRecognizer()
      super.init()
      gestureRecognizer.addTarget(self, action: #selector(pan))
   }
   
   func pan(gestureRecognizer : UIPanGestureRecognizer) {
      let translation = gestureRecognizer.translationInView(gestureRecognizer.view).y
      
      switch gestureRecognizer.state {
         case .Began:
            isActive = true
            if ((startBlock) != nil) {
               startBlock!()
            }
         case .Changed:
            let percent = min(max(2 * translation / CGRectGetHeight(gestureRecognizer.view!.bounds), 0.0), 1.0)
            updateInteractiveTransition(percent)
         case .Cancelled:
            isActive = false
            cancelInteractiveTransition()
         case .Ended:
            isActive = false
            let velocity = gestureRecognizer.velocityInView(gestureRecognizer.view).y
            if (velocity > 0) {
               finishInteractiveTransition()
            } else {
               cancelInteractiveTransition()
            }
         default: break
         
      }
   }
}
