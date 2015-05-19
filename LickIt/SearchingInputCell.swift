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
    
    @IBAction func butonPressed(sender: AnyObject) {
    println(input.text)
    
    }
    
        override func awakeFromNib() {
    
        super.awakeFromNib()
        // Initialization code
        let buton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        buton.frame = CGRect(x: self.input.frame.maxX, y: self.input.frame.minY, width: 40, height: self.input.frame.height)
        buton.setBackgroundImage(UIImage(named: "MenuButton"), forState: UIControlState.Normal)
        buton.addTarget(self, action: "butonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(buton)
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
