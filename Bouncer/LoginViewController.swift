//
//  LoginViewController.swift
//  Bouncer
//
//  Created by Daniel Kim on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //outlet
    let textField = UITextField()
    let textField2 = UITextField()
    
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
        
        //email
        let label = UILabel(frame: CGRect(x: 0, y: 50, width: 400, height: 1000))
        label.center = CGPoint(x:190,y:150)
        label.textAlignment = .center
        label.text = "Email:"
        label.font = label.font.withSize(50)
        label.textColor = UIColor.white
        self.view.addSubview(label)
        
        //textfield for email
        textField.backgroundColor = UIColor.white
        //textField.center = CGPoint(x:190, y:200)
        self.textField.placeholder = "email"
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -133).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    
        
        
        
        
        //Password
        let label2 = UILabel(frame: CGRect(x: 0, y: 400, width: 400, height: 1000))
        label2.center = CGPoint(x:190,y:250)
        label2.textAlignment = .center
        label2.text = "Password:"
        label2.font = label.font.withSize(50)
        label2.textColor = UIColor.white
        self.view.addSubview(label2)
        
        //textfield for password
        
        textField2.backgroundColor = UIColor.white
        textField2.placeholder = "password"
        textField2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField2)
        
        textField2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -33).isActive = true
        textField2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
        textField2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        textField2.isSecureTextEntry = true

        
        //login button
        let button = UIButton(frame: CGRect(x:135  , y:330, width:100, height:50))
        button.backgroundColor = UIColor.white
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action:#selector(Login), for:.touchUpInside)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.view.addSubview(button)


        
    }
     func Login(_ sender: AnyObject){
        if self.textField.text == "" || self.textField2.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.textField.text!, password: self.textField2.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    let login = GenerateGuestInvite()
                    self.navigationController?.pushViewController(login, animated: true)
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }}
}
