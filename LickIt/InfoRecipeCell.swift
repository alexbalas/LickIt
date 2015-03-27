//
//  InfoRecipeCell.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

protocol InfoRecipeCellDelegate {
    func infoRecipeCellSaveButtonPressed(cell : InfoRecipeCell)
}

class InfoRecipeCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var licks: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var delegate : InfoRecipeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func saveButtonPressed(sender: UIButton) {
        delegate?.infoRecipeCellSaveButtonPressed(self)
    }
}
