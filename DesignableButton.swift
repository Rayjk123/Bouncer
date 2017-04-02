//
//  DesignableButton.swift
//  Bouncer
//
//  Created by Daniel Kim on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit
@IBDesignable

class DesignableButton: UIButton {

    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }


    
    @IBInspectable var glowWhite: CGFloat = 0{
        didSet{
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.9
        self.layer.masksToBounds = false
    }
    }
    @IBInspectable var glowblue: CGFloat = 0{
        didSet{
        self.layer.shadowColor = UIColor.niceBlue().cgColor
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.9
        self.layer.masksToBounds = false
        }
    }
    @IBInspectable var StrongGlowBlue: CGFloat = 0{
        didSet{
            self.layer.shadowColor = UIColor.niceBlue().cgColor
            self.layer.shadowRadius = 7.0
            self.layer.shadowOpacity = 0.9
            self.layer.masksToBounds = false
        }
    }
 

    
    
    

 
}
