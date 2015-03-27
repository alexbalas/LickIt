//
//  CommentsCell.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class CommentsRecipeCell: UITableViewCell {

    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var commentTime: UILabel!
    @IBOutlet weak var commentContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
