//
//  SavedCoasterTableViewCell.swift
//  PanPractice
//
//  Created by Amanda Harman on 3/29/17.
//  Copyright © 2017 Amanda Harman. All rights reserved.
//

import UIKit

class SavedCoasterTableViewCell: UITableViewCell {

  @IBOutlet weak var coasterImage: UIView!
  @IBOutlet weak var label: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
