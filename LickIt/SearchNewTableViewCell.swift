//
//  SearchNewTableViewCell.swift
//  LickIt
//
//  Created by MBP on 15/09/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class SearchNewTableViewCell: UITableViewCell {
  
  
  @IBOutlet weak var imagine: UIImageView!
  
  @IBOutlet weak var name: UILabel!
  
  @IBOutlet weak var licks: UILabel!
  
  
  static func searchCell() -> SearchNewTableViewCell {
    
    return NSBundle.mainBundle().loadNibNamed("SearchNewTableViewCell", owner: self, options: nil)[0] as! SearchNewTableViewCell
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
