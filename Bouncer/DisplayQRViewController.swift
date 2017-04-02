//
//  DisplayQRViewController.swift
//  Bouncer
//
//  Created by Branden Lee on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class DisplayQRViewController: UIViewController{
    private lazy var storage = FIRStorage.storage()
    
    var inviteInstance: Invites?
    
    var qrImageURL: String?
    
    var qrImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupImageView()
        setQRImage()
    }
    
    func setupImageView(){
        qrImage = UIImageView()
        qrImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(qrImage)
        
        qrImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        qrImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        qrImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        qrImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setQRImage(){
        func setupEventImage(){
            let storageRef = storage.reference(forURL: (inviteInstance?.qrImageURL)!)
            storageRef.data(withMaxSize: (1024 * 1024), completion: { (data, error) -> Void in
                self.qrImage?.image = UIImage(data: data!)
            })
        }
    }
    
}
