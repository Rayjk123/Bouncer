//
//  DesignableTextField.swift
//  Bouncer
//
//  Created by Daniel Kim on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit
@IBDesignable

class DesignableTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var leftImage: UIImage?{
        didSet{
            updateView()
        }
        
    }

    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet{
            updateView()
        }
    }

    @IBInspectable var glow: CGFloat = 0{
        didSet{
            self.layer.shadowColor = UIColor.white.cgColor
            self.layer.shadowRadius = 4.0
            self.layer.shadowOpacity = 0.9
            self.layer.masksToBounds = false
        }
    }

    func updateView() {

        if let image = leftImage {
            leftViewMode = .always

            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
                imageView.image = image

            var width = leftPadding + 20

            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line{
                width = width + 5
            }

            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)

            leftView = view
        } else {
            leftViewMode = .never
        }

        attributedPlaceholder = NSAttributedString(string: placeholder!, attributes:[NSForegroundColorAttributeName: tintColor])
    }
}
