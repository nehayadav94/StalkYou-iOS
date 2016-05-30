//
//  PostCard.swift
//  StalkYou
//
//  Created by Neha Yadav on 28/05/16.
//  Copyright © 2016 Neha Yadav. All rights reserved.
//

import Foundation
import UIKit

class PostCard: UITableViewCell {
    
    @IBOutlet weak var shadowedView : ShadowedContainerView!
    @IBOutlet weak var postImage : UIImageView!
    @IBOutlet weak var captionLabel : UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .None
        
    }
}
