//
//  SignInViewController.swift
//  Snapchat
//
//  Created by Michael Shepherd on 25/05/2017.
//  Copyright © 2017 Shepherd Apps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func turnUpTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            
            if error != nil {
                print("There was an error: \(String(describing: error))")
                
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    
                    if error != nil {
                        print("There was an error: \(String(describing: error))")
                    }else {
                        print("Created user successfully")
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                    }
                })
                
            } else {
                print("Signed in succesfully")
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        })
    }
}

