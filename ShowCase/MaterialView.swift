//
//  MaterialView.swift
//  ShowCase
//
//  Created by david johnson on 2016/10/17.
//  Copyright © 2016 hiddenplatform. All rights reserved.
//

import UIKit

class MaterialView: UIView {

    override func awakeFromNib() {
        //SHADOW_COLOR = 157.0 / 255.0
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)

    }

}
