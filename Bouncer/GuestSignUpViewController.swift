//
//  GuestSignUp.swift
//  Bouncer
//
//  Created by Daniel Kim on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth

class GuestSignUpViewController: UIViewController, UITextFieldDelegate{
    
    let textField = UITextField()
    let textField2 = UITextField()
    let button = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    let label = UILabel()
    let label2 = UILabel()
    
    var signIn = true
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
        
        //self.navigationController?.navigationBar.isHidden = false
        
        //button to register
        button.backgroundColor = UIColor.white
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action:#selector(registerPressed), for:.touchUpInside)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        button.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 300).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //button to sign up
        button2.backgroundColor = UIColor.white
        button2.setTitle("Sign In", for: .normal)
        button2.addTarget(self, action:#selector(signInPressed), for:.touchUpInside)
        button2.setTitleColor(UIColor.black, for: UIControlState.normal)
        button2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button2)
        
        button2.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        button2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        button2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 300).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button2.leftAnchor.constraint(equalTo: button.rightAnchor, constant: 10).isActive = true
        
        //button that will alternate between login and register
        button3.backgroundColor = UIColor.white
        button3.addTarget(self, action:#selector(handleButton), for:.touchUpInside)
        button3.setTitleColor(UIColor.black, for: UIControlState.normal)
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.setTitle("Sign In", for: .normal)
        self.view.addSubview(button3)
        
        button3.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 300).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button3.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        
        
        //Label for Guest Email
        label.textAlignment = .left
        label.text = "Email:"
        label.font = label.font.withSize(30)
        label.textColor = UIColor.white
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30).isActive = true
        
        //label for password
        label2.textAlignment = .left
        label2.text = "Password:"
        label2.font = label.font.withSize(30)
        label2.textColor = UIColor.white
        self.view.addSubview(label2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30).isActive = true
        
        //textfield for email
        textField.backgroundColor = UIColor.white
        textField.textAlignment = .left
        textField.placeholder = "Email"
        self.view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        
        //textfield for password
        textField2.backgroundColor = UIColor.white
        textField2.textAlignment = .left
        textField2.placeholder = "Password"
        self.view.addSubview(textField2)
        textField2.translatesAutoresizingMaskIntoConstraints = false
        
        textField2.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30).isActive = true
        textField2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        textField2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField2.isSecureTextEntry = true
    }
    func signInPressed(){
        button3.setTitle("Sign In", for: .normal)
        textField.text = ""
        textField2.text = ""
        signIn = true
    }
    
    func registerPressed(){
        textField.text = ""
        textField2.text = ""
        button3.setTitle("Register", for: .normal)
        signIn = false
    }
    
    func handleButton(){
        if(signIn){
            print("Enter Sign in")
            signInButtonTapped()
        }
        else{
            print("Enter Register")
            registerButtonPressed()
        }
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
