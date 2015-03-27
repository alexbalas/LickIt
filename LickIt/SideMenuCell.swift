//
//  SideMenuCell.swift
//  LickIt
//
//  Created by MBP on 09/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var imagine: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagine.image = UIImage(contentsOfFile: "1")
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
