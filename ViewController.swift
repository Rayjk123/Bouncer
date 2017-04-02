//
//  ViewController.swift
//  Anthem
//
//  Created by Daniel Kim on 3/31/17.
//  Copyright © 2017 Daniel Kim. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    let button = UIButton()
    let button2 = UIButton()
    let label = UILabel()
    let label2 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //background color
        self.view.backgroundColor = UIColor.blue
        
        //create the UI button "Guest Check in" and "Sign a Guest in".
        button.backgroundColor = UIColor.white
        button.setTitle("Guest Sign In/Registration", for: .normal)
        button.addTarget(self, action:#selector(clickMe), for:.touchUpInside)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive=true
        
        
        button2.backgroundColor = UIColor.white
        button2.setTitle("Check a Guest In", for: .normal)
        button2.addTarget(self, action:#selector(clickMe2), for:.touchUpInside)
        button2.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.view.addSubview(button2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button2.topAnchor.constraint(equalTo: button.topAnchor, constant: 100).isActive = true
        
        
        
        //Create "welcome to bouncer"
        label.center = CGPoint()
        label.textAlignment = .center
        label.text = "Welcome to"
        label.font = label.font.withSize(50)
        label.textColor = UIColor.white
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250).isActive = true
        label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        label2.center = CGPoint(x:185,y:150)
        label2.textAlignment = .center
        label2.text = "Bouncer!"
        label2.font = label.font.withSize(50)
        label2.textColor = UIColor.white
        self.view.addSubview(label2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40).isActive = true
        
        
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        
        
    }
    func clickMe(sender:UIButton!){ // Sign a guest in
        let guest = GuestSignUp()
        self.navigationController?.pushViewController(guest, animated: true)
        
    }
    
    func clickMe2(sender:UIButton!){ //Guest check in
        let login = LoginViewController()
        self.navigationController?.pushViewController(login, animated: true)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

