//
//  ViewController.swift
//  faceIDLogin
//
//  Created by Kell Lanes on 07/07/21.
//

import UIKit
import LocalAuthentication
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextFields: UITextField!
    @IBOutlet weak var passwordTextFields: UITextField!
    @IBOutlet weak var btnLoginWhitFaceId: UIButton!
    @IBOutlet weak var btnChangeAccount: UIButton!
    @IBOutlet weak var btnGoToSignup: UIButton!
    
    var auth:Auth?
    var userdefaults = UserDefaults.standard
    var context = LAContext()
    var err : NSError?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSavedUser()
        self.auth = Auth.auth()
    }
    
    func checkSavedUser() {
        if (userdefaults.value(forKey: "email") != nil) &&
            (userdefaults.value(forKey: "pwd") != nil) {
            btnLoginWhitFaceId.isHidden = false
            btnChangeAccount.isHidden = false
            btnGoToSignup.isHidden = true
            self.emailTextFields.isEnabled = false
            emailTextFields.text = self.userdefaults.value(forKey: "email") as? String
        }
        else {
            btnLoginWhitFaceId.isHidden = true
            btnChangeAccount.isHidden = true
            btnGoToSignup.isHidden = false
        }
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        let email:String = self.emailTextFields.text ?? ""
        let password:String = self.passwordTextFields.text ?? ""
        
        self.auth?.signIn(withEmail: email, password: password, completion: { (usuario, error) in
            if error != nil {
                print("Dados incorretos, tente novamente")
            } else {
                if usuario == nil {
                    print("Error! Usuário não encontrado")
                } else {
                    print("Sucesso no Login!!!")
                    self.userdefaults.set(email, forKey: "email")
                    self.userdefaults.set(password, forKey: "pwd")
                    let vc =  self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                    vc.parentVC = self
                    self.present(vc, animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBAction func btnLoginWithFaceId(_ sender: Any) {
        let localString = "Autenticação Biométrica"
        if context.canEvaluatePolicy(LAPolicy
                                        .deviceOwnerAuthenticationWithBiometrics, error: &err) {
            if context.biometryType == .faceID {
                print("Face id biometrics")
                btnLoginWhitFaceId.setTitle("Login com FaceId", for: .normal)
            }
            else if context.biometryType == .touchID {
                print("Touch id biometrics")
                btnLoginWhitFaceId.setTitle("Login com TouchId", for: .normal)
            }
            else {
                print("No Biometrics")
            }
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: localString) { (success, error ) in
                if success {
                    DispatchQueue.main.async {
                        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                        vc.parentVC = self
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func logoutUser() {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "pwd")
        emailTextFields.text = ""
        passwordTextFields.text = ""
        self.emailTextFields.isEnabled = true
        checkSavedUser()
    }

    @IBAction func btnChangeAccountAction(_ sender: Any) {
        logoutUser()
    }
    
    
    

}

