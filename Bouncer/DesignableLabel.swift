//
//  DesignableButton.swift
//  Bouncer
//
//  Created by Daniel Kim on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit
@IBDesignable

class DesignableLabel: UILabel {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var glow: CGFloat = 0{
        didSet{
            self.layer.shadowColor = shadowColor?.cgColor
            self.layer.shadowRadius = 4.0
            self.layer.shadowOpacity = 0.9
            self.layer.masksToBounds = false
        }

    }

}
