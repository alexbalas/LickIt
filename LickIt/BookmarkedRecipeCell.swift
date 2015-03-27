//
//  BookmarkedRecipeCell.swift
//  LickIt
//
//  Created by MBP on 08/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class BookmarkedRecipeCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imagine: UIImageView!
    @IBAction func button(sender: UIButton) {
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
