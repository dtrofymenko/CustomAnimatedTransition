//
//  TableViewCell.swift
//  CustomAnimatedTransition
//
//  Created by Dmytro Trofymenko on 4/18/16.
//  Copyright © 2016 Dmytro Trofymenko. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
   @IBOutlet weak var titleLabel: UILabel!
   @IBOutlet weak var avatarView: UIImageView!
   
   override func layoutSubviews() {
      super.layoutSubviews()
      avatarView.layer.cornerRadius = CGRectGetWidth(avatarView.frame) / 2
   }
}
