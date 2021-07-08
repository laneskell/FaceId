//
//  ViewController.swift
//  faceIDLogin
//
//  Created by Kell Lanes on 07/07/21.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextFields: UITextField!
    @IBOutlet weak var passwordTextFields: UITextField!
    @IBOutlet weak var btnLoginWhitFaceIdExit: UIButton!
    
    var userdefaults = UserDefaults.standard
    var context = LAContext()
    var err : NSError?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (userdefaults.value(forKey: "email") != nil) &&
            (userdefaults.value(forKey: "pwd") != nil) {
            btnLoginWhitFaceIdExit.isHidden = false
        }
        else {
            btnLoginWhitFaceIdExit.isHidden = true
        }
    }
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        if !(emailTextFields.text!.isEmpty) && !(passwordTextFields.text!.isEmpty) {
            userdefaults.set(emailTextFields.text, forKey: "email")
            userdefaults.set(passwordTextFields.text, forKey: "pwd")
            let vc =  storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnLoginWithFaceId(_ sender: Any) {
        let localString = "Autenticação Biométrica"
        if
            context.canEvaluatePolicy(LAPolicy
                                        .deviceOwnerAuthenticationWithBiometrics, error: &err) {
            if context.biometryType == .faceID {
                print("Face id biometrics")
                emailTextFields.attributedPlaceholder = NSAttributedString(string: self.userdefaults.value(forKey: "email") as! String )
                btnLoginWhitFaceIdExit.setTitle("Login com FaceId", for: .normal)
            }
            else if context.biometryType == .touchID {
                print("Touch id biometrics")
                emailTextFields.attributedPlaceholder = NSAttributedString(string: self.userdefaults.value(forKey: "email") as! String )
                btnLoginWhitFaceIdExit.setTitle("Login com TouchId", for: .normal)
            }
            else {
                print("No Biometrics")
            }
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: localString) { (success, error ) in
                if success {
                    let email = self.userdefaults.value(forKey: "email") as! String
                    let pwd = self.userdefaults.value(forKey: "pwd") as! String
                    
                    DispatchQueue.main.async {
                        print("email=\(email) pwd =\(pwd)")
                        
                        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
}

