//
//  MaterialTextField.swift
//  ShowCase
//
//  Created by david johnson on 2016/10/17.
//  Copyright © 2016 hiddenplatform. All rights reserved.
//

import UIKit

class MaterialTextField: UITextField {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.1).CGColor
        layer.borderWidth = 1.0
    }
    
    //For placeholder - adds a placeholder on the text field
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    //For Editable Text - when in edit mode set the same
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
}
