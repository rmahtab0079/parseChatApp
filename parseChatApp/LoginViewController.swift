//
//  LoginViewController.swift
//  parseChatApp
//
//  Created by Rageeb Mahtab on 3/13/19.
//  Copyright © 2019 Rageeb Mahtab. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    let alertController = UIAlertController(title: "Title", message: "Your Username or Password field cannot be blank", preferredStyle: .alert)

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onTapSignUp(_ sender: Any) {
        registerUser()
    }
    
    @IBAction func onTapLogin(_ sender: Any) {
        loginUser()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        
        if (usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)! {
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
                self.alert()
            }
        } else {
            newUser.username = usernameField.text
            newUser.password = passwordField.text
        }
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print("User registration failed \(error.localizedDescription)")
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
             
            }
        }
        
    }
    
    func loginUser() {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        
        if (usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)! {
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
                self.alert()
            }
        }
        
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    func alert() {
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        self.alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.viewDidLoad()
        }
        // add the OK action to the alert controller
        self.alertController.addAction(OKAction)
        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
