//
//  LoginViewController.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 11/20/20.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import LocalAuthentication

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let dbref = Database.database().reference()
    let storageRef = Storage.storage().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener(){auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "instrumentSegue", sender: nil)
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
    }
    
    let userInfoKeyConstant = "userIDpassword"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getSaveDefaults() {
        let defaults = UserDefaults.standard
        
        if let creds = defaults.dictionary(forKey: userInfoKeyConstant) {
            print("get creds")
            if let id = creds["userid"] {
                emailTextField.text = id as? String
            }
            
            if let password = creds["password"] {
                passwordTextField.text = password as? String
            }
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            email.count > 0,
            password.count > 0
        else {
            return
        }
        
        let defaults = UserDefaults.standard
        let creds: Dictionary<String,String> = ["userid": email, "password": password]
        
        defaults.set(creds,forKey: self.userInfoKeyConstant)
        
        //logic for login
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed", message: error.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
            }
    }
    
}
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Register", message: "Enter email and password", preferredStyle: .alert)
        let saveAction = UIAlertAction(title:"Save", style: .default) {_ in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) {user, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!)
                } else {
                    
                    let alert = UIAlertController(title:"User reation failed", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"OK", style: .default))
                    
                    self.present(alert,animated: true, completion: nil)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title:"Cancel", style:.cancel)
        
        alert.addTextField { emailText in
            emailText.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true, completion: nil)
    }
    
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = " "
        if #available(iOS 11.0, *) {
            switch errorCode {
            
            case LAError.biometryNotAvailable.rawValue:
                message = "Authentication could not start because the device does not support biometric authentication."
                // case LAError.biometryNotAvailable.rawValue:
                //message = "Authentication could not start because the device does not support biometric authentication."
                
            case LAError.biometryLockout.rawValue:
                message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                
            case LAError.biometryNotEnrolled.rawValue:
                message = "Authentication could not start because the user has not enrolled in biometric authentication."
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
            case LAError.biometryLockout.rawValue:
                message = "Too many failed attempts."
                
            case LAError.biometryNotAvailable.rawValue:
                message = "LAErrorBiometryNotAvailable on the device"
                
            case LAError.biometryNotEnrolled.rawValue:
                message = "LAErrorBiometryNotEnrolled on the device"
                
            default:
                message = "Did not find error code on LAError object"
            }
        }
        
        return message;
            
    }
    
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
    }
