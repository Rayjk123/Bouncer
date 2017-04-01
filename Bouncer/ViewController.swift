//
//  ViewController.swift
//  Bouncer
//
//  Created by Branden Lee on 3/31/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        let button = UIButton(frame: CGRect(x:0, y:0, width:100, height: 100))
        button.tintColor = UIColor.red
        
        self.view.addSubview(button)
        button.setTitle("Hi", for: .normal)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

