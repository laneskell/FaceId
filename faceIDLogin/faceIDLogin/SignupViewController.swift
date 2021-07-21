//
//  SingupViewController.swift
//  faceIDLogin
//
//  Created by Kell Lanes on 21/07/21.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var textFieldEmailSignup: UITextField!
    @IBOutlet weak var textFieldPasswordSignup: UITextField!
    
    var auth:Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.auth = Auth.auth()

      
    }
    
    @IBAction func btnSignup(_ sender: Any) {
        let email:String =  self.textFieldEmailSignup.text ?? ""
        let password:String = self.textFieldPasswordSignup.text ?? ""
        
        self.auth?.createUser(withEmail: email, password: password, completion: { result, error in
            if error != nil {
                print("Falha no cadastro!")
            } else {
                print("Sucesso no cadastro")
            }
        })
    }
    
    @IBAction func btnBackLogin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
