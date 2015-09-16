//
//  BookmarkedTableViewCell.swift
//  LickIt
//
//  Created by MBP on 15/09/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class BookmarkedTableViewCell: UITableViewCell {

    @IBOutlet weak var imagine: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
