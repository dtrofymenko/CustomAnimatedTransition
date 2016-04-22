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
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      panTransitionInteractor = PanTransitionInteractor()
      view.addGestureRecognizer(panTransitionInteractor!.gestureRecognizer)
      
      panTransitionInteractor!.startBlock = { () -> () in
         self.dismissViewControllerAnimated(true, completion: nil)
      }
   }
}