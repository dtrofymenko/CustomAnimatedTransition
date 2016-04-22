//
//  ViewController.swift
//  CustomAnimatedTransition
//
//  Created by Dmytro Trofymenko on 4/11/16.
//  Copyright © 2016 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIViewControllerTransitioningDelegate {
   
   var selectedIndexPath : NSIndexPath?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }

   @IBAction func unwind(segue : UIStoryboardSegue) {}
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      segue.destinationViewController.transitioningDelegate = self;
      self.selectedIndexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)!
      let destinationViewController = segue.destinationViewController as! ModalViewController
      if (nil != destinationViewController.view) {
         switch self.selectedIndexPath!.row {
            case 0:
               destinationViewController.textLabel.text = "C-3PO"
               destinationViewController.imageView.image = UIImage(named: "c3po")
            case 1:
               destinationViewController.textLabel.text = "R2D2"
               destinationViewController.imageView.image = UIImage(named: "r2d2")
            default:break
         }
      }
   }
   
   func animationControllerForPresentedController(
      presented: UIViewController,
      presentingController presenting: UIViewController,
                           sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      if (0 == self.selectedIndexPath?.row) {
         return SimpleTransitionAnimator();
      } else {
         return AdvancedTransitionAnimator();
      }
   }
   
   func animationControllerForDismissedController(dismissed: UIViewController) ->
      UIViewControllerAnimatedTransitioning? {
      if (0 == self.selectedIndexPath?.row) {
         let animator = SimpleTransitionAnimator();
         animator.isPresentationTransition = false
         return animator
      } else {
         let animator = AdvancedTransitionAnimator();
         animator.isPresentationTransition = false
         return animator
      }
   }

   func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) ->
      UIViewControllerInteractiveTransitioning? {
      if let panTransitionInteractor = (presentedViewController as! ModalViewController).panTransitionInteractor {
         return panTransitionInteractor.isActive ? panTransitionInteractor : nil
      } else {
         return nil
      }
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 2
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
      UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell") as! TableViewCell
      switch indexPath.row {
         case 0:
            cell.titleLabel?.text = "C-3PO"
            cell.avatarView?.image = UIImage(named: "c3po")
         case 1:
            cell.titleLabel?.text = "R2D2"
            cell.avatarView?.image = UIImage(named: "r2d2")
         default:break
      }
      
      return cell
   }
}

