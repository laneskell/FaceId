//
//  WelcomeViewController.swift
//  faceIDLogin
//
//  Created by Kell Lanes on 07/07/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        DispatchQueue.main.async {
            let backViewController =  self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.present(backViewController, animated: true, completion: nil)
        }

    }
    }
    



