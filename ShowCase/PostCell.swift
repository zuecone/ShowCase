//
//  PostCell.swift
//  ShowCase
//
//  Created by david johnson on 2016/10/23.
//  Copyright © 2016 hiddenplatform. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    
        // Initialization code
    }
    
    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2.0
        profileImg.clipsToBounds = true
        
        showcaseImg.clipsToBounds = true
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
