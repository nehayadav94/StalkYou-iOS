//
//  ContainerView.swift
//  client
//
//  Created by Neha Yadav on 01/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class ShadowedContainerView: UIView {
    
    override func awakeFromNib() {
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 0.5
        layer.shadowColor = UIColor(red: 138.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1.0).CGColor
        layer.shadowOffset = CGSizeMake(0, 0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 2.0
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
