//
//  ModalViewController.swift
//  CustomAnimatedTransition
//
//  Created by Dmytro Trofymenko on 4/11/16.
//  Copyright © 2016 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class ModalViewController : UIViewController {
   var panTransitionInteractor : PanTransitionInteractor?
   @IBOutlet weak var textLabel : UILabel!
   @IBOutlet weak var imageView : UIImageView!
   
//   override func viewWillAppear(animated: Bool) {
//      super.viewWillAppear(animated)
//      if (nil != self.transitionCoordinator()) {
//         self.view.backgroundColor = UIColor.greenColor()
//         self.transitionCoordinator()?.animateAlongsideTransition({ (context) in
//            self.view.backgroundColor = UIColor.redColor()
//         }, completion: nil)
//      }
//   }
//   
//   override func viewWillDisappear(animated: Bool) {
//      super.viewWillDisappear(animated)
//      if (nil != self.transitionCoordinator()) {
//         self.view.backgroundColor = UIColor.redColor()
//         self.transitionCoordinator()?.animateAlongsideTransition({ (context) in
//            self.view.backgroundColor = UIColor.greenColor()
//         }, completion:{ (context) in
//            if (context.isCancelled()) {
//               self.view.backgroundColor = UIColor.redColor()
//            }
//         })
//      }
//   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      panTransitionInteractor = PanTransitionInteractor()
      view.addGestureRecognizer(panTransitionInteractor!.gestureRecognizer)
      
      panTransitionInteractor!.startBlock = { [weak self] () -> () in
         self?.dismissViewControllerAnimated(true, completion: nil)
      }
   }
}