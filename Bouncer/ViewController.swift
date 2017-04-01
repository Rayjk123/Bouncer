//
//  ViewController.swift
//  Anthem
//
//  Created by Daniel Kim on 3/31/17.
//  Copyright © 2017 Daniel Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //background color
        self.view.backgroundColor = UIColor.blue
        
        //create the UI button "Guest Check in" and "Sign a Guest in".
        let button = UIButton(frame: CGRect(x:90  , y:250, width:200, height:100))
        button.backgroundColor = UIColor.white
        button.setTitle("Sign a Guest In", for: .normal)
        button.addTarget(self, action:#selector(clickMe), for:.touchUpInside)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.view.addSubview(button)
        
        let button2 = UIButton(frame: CGRect(x:90  , y:380, width:200, height:100))
        button2.backgroundColor = UIColor.white
        button2.setTitle("Guest Check In", for: .normal)
        button2.addTarget(self, action:#selector(clickMe2), for:.touchUpInside)
        button2.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.view.addSubview(button2)
        
        
        //Create "welcome to bouncer"
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: 400, height: 1000))
        label.center = CGPoint(x:190,y:100)
        label.textAlignment = .center
        label.text = "Welcome to"
        label.font = label.font.withSize(50)
        label.textColor = UIColor.white
        self.view.addSubview(label)
        
        var label2 = UILabel(frame: CGRect(x: 0, y: 100, width: 400, height: 1000))
        label2.center = CGPoint(x:185,y:150)
        label2.textAlignment = .center
        label2.text = "Bouncer!"
        label2.font = label.font.withSize(50)
        label2.textColor = UIColor.white
        self.view.addSubview(label2)
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        
        
    }
    func clickMe(sender:UIButton!){ // Sign a guest in
        
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

