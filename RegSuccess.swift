//
//  RegSuccess.swift
//  Bouncer
//
//  Created by Daniel Kim on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit

class RegSuccess: UIViewController, UITextFieldDelegate{
    

    let button4 = UIButton()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
        
        //Label for Registration
        label.textAlignment = .center
        label.text = "Registration was Successful!"
        label.font = label.font.withSize(20 )
        label.textColor = UIColor.white
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //back button
        button4.backgroundColor = UIColor.white
        button4.addTarget(self, action:#selector(goBack), for:.touchUpInside)
        button4.setTitleColor(UIColor.black, for: UIControlState.normal)
        button4.translatesAutoresizingMaskIntoConstraints = false
        button4.setTitle("Back", for: .normal)
        self.view.addSubview(button4)
        
        button4.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        button4.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 300).isActive = true
        button4.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        

        

        
    }
    @IBAction func goBack(_ sender: UISegmentedControl){
        let back = ViewController()
        self.navigationController?.pushViewController(back, animated: true)
    }

}
