//
//  SearchingInputCell.swift
//  LickIt
//
//  Created by MBP on 01/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class SearchingInputCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var input: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    internal func configure(#text: String?, placeholder: String) {
        input.text = text
        input.placeholder = placeholder
        
        input.accessibilityValue = text
        input.accessibilityLabel = placeholder
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }

}
