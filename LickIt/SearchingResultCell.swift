//
//  SearchingResultCell.swift
//  LickIt
//
//  Created by MBP on 01/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class SearchingResultCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var licks: UILabel!
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
