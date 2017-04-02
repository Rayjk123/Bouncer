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

class GuestSignUp: UIViewController, UITextFieldDelegate{
    
    let textField = UITextField()
    let textField2 = UITextField()
    let button = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    let label = UILabel()
    let label2 = UILabel()
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
        
        //button to register
        button.backgroundColor = UIColor.white
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action:#selector(signInSelectorChanged), for:.touchUpInside)
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
        button2.addTarget(self, action:#selector(signInSelectorChanged), for:.touchUpInside)
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
        button3.addTarget(self, action:#selector(signInButtonTapped), for:.touchUpInside)
        button3.setTitleColor(UIColor.black, for: UIControlState.normal)
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.setTitle("Register", for: .normal)
        self.view.addSubview(button3)
        
        button3.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 300).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button3.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        
        button4.backgroundColor = UIColor.white
        button4.addTarget(self, action:#selector(goBack), for:.touchUpInside)
        button4.setTitleColor(UIColor.black, for: UIControlState.normal)
        button4.translatesAutoresizingMaskIntoConstraints = false
        button4.setTitle("Back", for: .normal)
        self.view.addSubview(button4)
        
        button4.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        button4.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 300).isActive = true
        button4.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        


        
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
        textField.placeholder = "email"
        self.view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
        
        
    
        //textfield for password
        textField2.backgroundColor = UIColor.white
        textField2.textAlignment = .left
        textField2.placeholder = "password"
        self.view.addSubview(textField2)
        textField2.translatesAutoresizingMaskIntoConstraints = false
        
        textField2.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30).isActive = true
        textField2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        textField2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField2.isSecureTextEntry = true
    


        



    }
    @IBAction func goBack(_ sender: UISegmentedControl){
        let back = ViewController()
        self.navigationController?.pushViewController(back, animated: true)

        
    }
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl){
        isSignIn = !isSignIn
        if isSignIn{
            
            button3.setTitle("Sign In", for: .normal)
        
        }
        else{
            button3.setTitle("Register", for: .normal)
        }
    }
    @IBAction func signInButtonTapped(_ sneder: UIButton){
            if isSignIn{
                if self.textField.text == "" || self.textField2.text == "" {
                    
                    //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
                    
                    let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {

                
                FIRAuth.auth()?.signIn(withEmail: self.textField.text!, password: self.textField2.text!)
                { (user, error) in
                    
                    if error == nil {
                        
                        //Print into the console if successfully logged in
                        print("You have successfully logged in")
                        
                       let login = InvitesViewController()
                        self.navigationController?.pushViewController(login, animated: true)
                    } else {
                        
                        //Tells the user that there is an error and then gets firebase to tell them the error
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    }
            
                }
            }
            else{
                if self.textField.text == "" || self.textField2.text == "" {
                    
                    //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
                    
                    let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                else {
                    FIRAuth.auth()?.createUser(withEmail: self.textField.text!, password: self.textField2.text!, completion: { (user, error) in
                        if error != nil{
                            let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                            
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                           
                            
                            
                        }else{
                            let Reg = RegSuccess()
                            self.navigationController?.pushViewController(Reg, animated: true)
                            
                        }
                        }
               )}

                
                        
                
                    
        
                }
    }
}
