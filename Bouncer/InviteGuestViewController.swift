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
    private var firstTime = true
    private var hasValidated = false
    
    
    @IBOutlet var textfield: DesignableTextField!
    
    @IBOutlet var button: DesignableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createQRCode()
        setupToolbar()
    }
    
    func setupToolbar(){
        let numberToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:50))
        numberToolbar.barStyle = UIBarStyle.default
        let keyboardDismiss = UIButton(frame: CGRect(x:0, y:0, width:22, height:22))
        keyboardDismiss.setImage(UIImage(named: "keyboard dismiss2"), for: UIControlState.normal)
        keyboardDismiss.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
        
        
        
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: keyboardDismiss)]
        numberToolbar.sizeToFit()
        textfield.inputAccessoryView = numberToolbar
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    
    @IBAction func giveInvite(sender: UIButton){
        let validTextField: Bool = checkValidTextField() //Check to see that the textfields are valid
        if(!firstTime){
            inviteRef = FIRDatabase.database().reference(withPath: "guests")
        }
        
        if(validTextField){ //Since the textfield is valid. Validate to see if the guest exists
            handleUser()
        }
    }
    
    //Check to make sure that the text field is filled out
    func checkValidTextField() -> Bool{
        if(textfield.text?.isEmpty)!{ //Check if the text field is empty
            let alertController = UIAlertController(title: "Submit Error", message: "Please fill out the textfield.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true)
            return false
        }
        else if(isValidEmail(testStr: textfield.text!) == false){ //Check if the email is not valid
            let alertController = UIAlertController(title: "Submit Error", message: "This is not a valid email address. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true)
            return false
        }
        return true
    }
    
    
    //Checks to see if the guest exists and acts upon it if the user does exist.
    //If the guest exists then send the guest a QR Code
    func handleUser(){
        var handle: UInt = 0
        let username = textfield.text!
        let index = username.index(username.endIndex, offsetBy: -4)
        var updatedUsername = username.substring(to: index)
        updatedUsername = updatedUsername.lowercased()
        handle = inviteRef.observe(.value, with: { (snapshot) in
            if(snapshot.hasChild(updatedUsername)){ //If the guest exists call createQRCode with the username
                self.createQRCode(username: updatedUsername)
                self.inviteRef.removeObserver(withHandle: handle)
                self.firstTime = false
                print("Entered Valid")
                self.hasValidated = true
                let alertController = UIAlertController(title: "Success", message: "You have succesfully sent the guest " + username + " your invite!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true)
            }
            else{
                if(self.hasValidated == false){
                    let alertController = UIAlertController(title: "Error", message: "This user does not exist. Please check to make sure you have entered the correct username.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertController, animated: true)
                    print("Entered Invalid")
                }
                else{
                    self.hasValidated = false
                }
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
        //Creates a QRImage which we will find the URL to and then pass that value into the assignQRCode function
        storeQRImage(qrCode: code, username: username)
        //assignQRCode(code: code, username: username)
        
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
    
    //This function controls the database by going to the user's invites section and adding in the Invite Info
    func assignQRCode(code: String, username: String, imageURL: String){
        let newRef = inviteRef.child(username).child("invites").childByAutoId()
        let codeRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "codes")
        codeRef.child(code).setValue(code)
        let invite = Invites(qrCode: code, owner: username, qrImageURL: imageURL)
        newRef.setValue(invite.toAnyObject())
    }
    
    
    //Self Explanitoty. It's hieroglyphics
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
}

