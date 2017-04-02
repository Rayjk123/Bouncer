//
//  HomeViewController.swift
//  Anthem
//
//  Created by Daniel Kim on 3/31/17.
//  Copyright © 2017 Daniel Kim. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

