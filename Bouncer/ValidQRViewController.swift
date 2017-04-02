//
//  ValidQRViewController.swift
//  Bouncer
//
//  Created by Branden Lee on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit

class ValidQRViewController: UIViewController{
    var valid: Bool?
    
    var image: UIImageView!
    var label: UILabel!
    var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor.white
        if(valid)!{
            setupUIElementsValid()
        }
        else{
            setupUIElementsInvalid()
        }
        
        setupConstraints()
    }
    
    //Adds all the necessary items to the uiviewcontroller and sets up their constraints
    func setupConstraints(){
        image.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(image)
        self.view.addSubview(label)
        self.view.addSubview(backButton)
        
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        image.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40).isActive = true
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        image.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        backButton.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        backButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupUIElementsValid(){
        label = UILabel()
        label.text = "Valid Guest"
        label.textColor = UIColor.midnightBlue()
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 30)
        
        image = UIImageView(image: UIImage(named: "Panda"))
        
        backButton = UIButton()
        backButton.setTitle("Back to Scanner", for: .normal)
        backButton.setTitleColor(UIColor.midnightBlue(), for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Arial", size: 30)
        backButton.backgroundColor = UIColor.lightGreen()
        backButton.addTarget(self, action: #selector(backToScanner), for: .touchUpInside)
        
    }
    
    func setupUIElementsInvalid(){
        label = UILabel()
        label.text = "DESTROY INTRUDER!"
        label.textColor = UIColor.midnightBlue()
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 30)
        
        image = UIImageView(image: UIImage(named:"Angry Panda"))
        
        backButton = UIButton()
        backButton.setTitle("Back to Scanner", for: .normal)
        backButton.setTitleColor(UIColor.midnightBlue(), for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Arial", size: 30)
        backButton.backgroundColor = UIColor.cabaret()
        backButton.addTarget(self, action: #selector(backToScanner), for: .touchUpInside)
    }
    
    func backToScanner(sender: UIButton){
        let viewController = ScannerViewController()
        self.present(viewController, animated: true, completion: nil)
    }
}
