//
//  inviteGuestViewController.swift
//  Bouncer
//
//  Created by Branden Lee on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit
import Firebase

class InviteGuestViewController: UIViewController {
    
    var textfield = UITextField()
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupUI()
    }
    
    func setupConstraints(){
        textfield.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(textfield)
        self.view.addSubview(button)
        
        textfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textfield.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        textfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textfield.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalTo: textfield.widthAnchor).isActive = true
        
    }
    
    func setupUI(){
        textfield.placeholder = "Enter Guest's Username"
        
        button.backgroundColor = UIColor.niceBlue()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.cloud(), for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 30)
        button.addTarget(self, action: #selector(giveInvite), for: .touchUpInside)
        
    }
    
    func giveInvite(sender: UIButton){
        
    }
    
    func validateUser(){
        
    }
    
    
}

