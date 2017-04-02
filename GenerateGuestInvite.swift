//
//  GenerateGuestInvite.swift
//  Bouncer
//
//  Created by Daniel Kim on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class GenerateGuestInvite: UIViewController, UITextFieldDelegate{
    
    let textField = UITextField()
    let label = UILabel()
    let button = UIButton()
    let button4 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
       
        //Label for Guest user
        label.textAlignment = .center
        label.text = "Guest Email:"
        label.font = label.font.withSize(50)
        label.textColor = UIColor.white
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
        
        
        //textfield to enter guest email.
        textField.backgroundColor = UIColor.white
        self.textField.placeholder = "Guest email"
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40).isActive = true
        
        //button to submit and generate code.
        button.backgroundColor = UIColor.white
        button.setTitle("Submit", for: .normal)
        button.addTarget(self, action:#selector(generateCode), for:.touchUpInside)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
    
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40).isActive = true
        
        button4.backgroundColor = UIColor.white
        button4.addTarget(self, action:#selector(goBack), for:.touchUpInside)
        button4.setTitleColor(UIColor.black, for: UIControlState.normal)
        button4.translatesAutoresizingMaskIntoConstraints = false
        button4.setTitle("Back", for: .normal)
        self.view.addSubview(button4)
        
        button4.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        button4.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 300).isActive = true
        button4.heightAnchor.constraint(equalToConstant: 50).isActive = true
        

        



        
        
    }
    @IBAction func goBack(_ sender: UISegmentedControl){
        let back = LoginViewController()
        self.navigationController?.pushViewController(back, animated: true)
        
        
    }
    func generateCode(textField: UITextField){
        
        if self.textField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            FIRAuth.auth()?.createUser(withEmail: self.textField.text!, password: "", completion: { (user, error) in
                if error != nil{
                    let alertController = UIAlertController(title: "Error", message: "Email not registered", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                   
                    
                }
                else{
                    
                    // let invite =
                    // self.navigationController?.pushViewController(invite, animated: true)
                    
                    //Create the code
                    print("hi")
                }
                }
            )}
        
            
           
}
}


