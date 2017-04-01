//
//  inviteGuestViewController.swift
//  Bouncer
//
//  Created by Branden Lee on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import QRCode

class InviteGuestViewController: UIViewController {
    private lazy var storageRef = FIRStorage.storage()
    private lazy var inviteRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "guests")
    private var inviteRefHandle: FIRDatabaseHandle?
    
    var textfield = UITextField()
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cloud()
        //inviteRef.child("panda@gmail.com").setValue("abcde")
        setupConstraints()
        setupUI()
        //createQRCode()
    }
    
    func setupConstraints(){
        textfield.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(textfield)
        self.view.addSubview(button)
        
        textfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textfield.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        textfield.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textfield.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalTo: textfield.widthAnchor, constant: -60).isActive = true
        
    }
    
    func setupUI(){
        textfield.placeholder = "Enter Guest's Username"
        textfield.backgroundColor = UIColor.cloud()
        textfield.textAlignment = .center
        textfield.font = UIFont(name: "Arial", size: 30)
        
        button.backgroundColor = UIColor.niceBlue()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.cloud(), for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 30)
        button.addTarget(self, action: #selector(giveInvite), for: .touchUpInside)
        
    }
    
    
    func giveInvite(sender: UIButton){
        let validTextField: Bool = checkValidTextField() //Check to see that the textfields are valid
        if(validTextField){ //Since the textfield is valid. Validate to see if the guest exists
            handleUser()
        }
    }
    
    //Check to make sure that the text field is filled out
    func checkValidTextField() -> Bool{
        if(textfield.text?.isEmpty)!{
            let alertController = UIAlertController(title: "Submit Error", message: "Please fill out the textfield.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true)
            return false
        }
        return true
    }
    
    
    //Checks to see if the guest exists and acts upon it if the user does exist.
    //If the guest exists then send the guest a QR Code
    func handleUser(){
        inviteRef.observe(.value, with: { (snapshot) in
            if(snapshot.hasChild(self.textfield.text!)){ //If the guest exists call createQRCode with the username
                self.createQRCode(username: self.textfield.text!)
                print("Entered Valid")
            }
            else{
                let alertController = UIAlertController(title: "Error", message: "This user does not exist. Please check to make sure you have entered the correct username.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true)
                print("Entered Invalid")
            }
        })
    }
    
    //Creates a random 4 alpha-digit code and returns it
    func createRandomCode() -> String {
        let length = 4
        let letters : NSString = "abcdefghijklmnopqrstuvwxyz0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        print("This is the random code " + randomString)
        return randomString
    }
    
    //calls all the QRCode Methods
    func createQRCode(username: String){
        let code = createRandomCode()
        //Creates a
        storeQRImage(qrCode: code, username: username)
        //assignQRCode(code: code, username: username)
        print(code)
        
    }
    
    //This method will take in the 4 alpha-digit
    func storeQRImage(qrCode: String, username: String){
        var imageURL = ""
        let qrCodeImage = QRCode(qrCode)
        //qrCode?.image
        let qrName = NSUUID().uuidString
        var storageRef = FIRStorage.storage().reference().child("Invites").child("\(qrName).jpg")
        //Set up Firebase Storage to store our image URL
        //Essentially if the image can be translated into a URL
        if let uploadImage = UIImageJPEGRepresentation((qrCodeImage?.image)!, 0.8){
            //Put it inside the Firebase storage
            storageRef.put(uploadImage, metadata: nil, completion: {(metadata, error) in
                if(error != nil){ //Check for error
                    print(error)
                    return
                }
                imageURL = (metadata?.downloadURL()?.absoluteString)!
                
                self.assignQRCode(code: qrCode, username: username, imageURL: imageURL)
            })
        }
        
    }
    
    func assignQRCode(code: String, username: String, imageURL: String){
        inviteRef.child(username).child("invites").setValue(code)
    }
    
    
}

