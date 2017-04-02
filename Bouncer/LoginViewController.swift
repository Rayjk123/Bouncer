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
    let button4 = UIButton()
    
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
        
        //email
        let label = UILabel(frame: CGRect(x: 0, y: 50, width: 400, height: 1000))
        label.center = CGPoint(x:190,y:150)
        label.textAlignment = .center
        label.text = "Your Email:"
        label.font = label.font.withSize(50)
        label.textColor = UIColor.white
        self.view.addSubview(label)
        
        //textfield for email
        textField.backgroundColor = UIColor.white
        self.textField.placeholder = "email"
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -133).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
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
        textField2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
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
        let userFromTextfield = textField.text?.lowercased()
        let passFromTextfield = textField2.text
        if userFromTextfield == "" || passFromTextfield == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: userFromTextfield!, password: passFromTextfield!) { (user, error) in
                
                if (error == nil) {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    self.checkIfOwner(email: userFromTextfield!)
                }
                    
                else {
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func checkIfOwner(email: String){
        let checkRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "owners")
        let index = email.index(email.endIndex, offsetBy: -4)
        var checkEmail = email.substring(to: index)
        checkEmail = checkEmail.lowercased()
        
        checkRef.observe(.value, with: { (snapshot) in
            if(snapshot.hasChild(checkEmail)){  //The code exists in the database
                let login = InviteGuestViewController()
                self.navigationController?.pushViewController(login, animated: true)
            }
            else{                         //The code does not exist int he database
                let alertController = UIAlertController(title: "Error", message: "I'm sorry but you are not an authorized user.", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        })
    
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
}
