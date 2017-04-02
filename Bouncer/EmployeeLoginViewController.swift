//
//  EmployeeLoginViewController.swift
//  Bouncer
//
//  Created by Daniel Kim on 4/1/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth


class EmployeeLoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var label: DesignableLabel!
    @IBOutlet var textField: DesignableTextField!
    @IBOutlet var textField2: DesignableTextField!
    @IBOutlet var button: DesignableButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField2.isSecureTextEntry = true
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
        textField.inputAccessoryView = numberToolbar
        textField2.inputAccessoryView = numberToolbar
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func Login(_ sender: AnyObject){
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
                let vc = ScannerViewController()
                self.navigationController?.pushViewController(vc, animated: true)
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
