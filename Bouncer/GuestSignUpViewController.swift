//
//  GuestSignUpViewController.swift
//  Bouncer
//
//  Created by Daniel Kim on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth

class GuestSignUpViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var button1: DesignableButton!
    
    @IBOutlet var button3: DesignableButton!
    @IBOutlet var button2: DesignableButton!
    var signIn = true
    
    @IBOutlet var textField: DesignableTextField!
    
    @IBOutlet var textField2: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField2.isSecureTextEntry = true
        setupToolbar()
    }
    
    @IBAction func signInPressed(){
        button3.setTitle("Sign In", for: .normal)
        textField.text = ""
        textField2.text = ""
        signIn = true
    }
    
    @IBAction func registerPressed(){
        textField.text = ""
        textField2.text = ""
        button3.setTitle("Register", for: .normal)
        signIn = false
    }
    
    @IBAction func handleButton(){
        if(signIn){
            print("Enter Sign in")
            signInButtonTapped()
        }
        else{
            print("Enter Register")
            registerButtonPressed()
        }
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
        textField.inputAccessoryView = numberToolbar
        textField2.inputAccessoryView = numberToolbar
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func signInButtonTapped(){
        let emailFromTextfield = textField.text?.lowercased()
        let passFromTextfield = textField2.text
        
        if(emailFromTextfield == "" || passFromTextfield == "") {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else {
            FIRAuth.auth()?.signIn(withEmail: emailFromTextfield!, password: passFromTextfield!) { (user, error) in
                
                if error != nil {
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    let login = InvitesViewController()
                    self.navigationController?.pushViewController(login, animated: true)
                    
                }
            }
        }
    }
    
    func registerButtonPressed(){
        print("Enter Register Pressed")
        let emailFromTextfield = textField.text?.lowercased()
        let passFromTextfield = textField2.text
        
        if emailFromTextfield == "" || passFromTextfield == "" {
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else {
            print("Enter FIRAuth Create User")
            FIRAuth.auth()?.createUser(withEmail: emailFromTextfield!, password: passFromTextfield!, completion: { (user, error) in
                if error != nil{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                else{
                    let email = emailFromTextfield!
                    let index = email.index(email.endIndex, offsetBy: -4)
                    let checkEmail = email.substring(to: index)
                    let inviteRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "guests")
                    inviteRef.child(checkEmail).child("password").setValue(passFromTextfield!)
                    print("Registration Success")
                    let alertController = UIAlertController(title: "Registration Success", message: "You have been succesfully registered!", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
}
