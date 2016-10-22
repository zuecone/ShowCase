//
//  ViewController.swift
//  ShowCase
//
//  Created by david johnson on 2016/10/17.
//  Copyright © 2016 hiddenplatform. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth


class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func fbBtnPressed(sender: UIButton!){
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResults: FBSDKLoginManagerLoginResult!, facebookError: NSError!) in
            if facebookError != nil{
                print("Facebook login failed \(facebookError)")
            }else{
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with facebook. \(accessToken)")

                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(accessToken)
                
                
                DataService.ds.REF_BASE.signInWithCredential(credential, completion: { (authData:FIRUser?, error: NSError?) in
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        //print("Logged in!")
                        NSUserDefaults.standardUserDefaults().setValue(authData?.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func attemptLogin(sender: UIButton!){
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            print("Details: " + email + "-" +  pwd)
            DataService.ds.REF_BASE.signInWithEmail(email, password: pwd, completion: { (authData:FIRUser?, error: NSError?) in
                
                if error != nil {
                    print(error?.code)
                   //if user doesn't exist
                    if error?.code == STATUS_ACCOUNT_NON_EXIST{
                        //now create account if user doesn't exist.
                        DataService.ds.REF_BASE.createUserWithEmail(email, password: pwd, completion: { (result:FIRUser?, error:NSError?) in
                            
                            if error != nil {
                                self.showErrorAlert("Could not create account", msg: "Problem creating account.  Try again")
                            }else{
                                //save the new users UID to the NSUserDefaults.
                                NSUserDefaults.standardUserDefaults().setValue(result?.uid, forKey: KEY_UID)
                                DataService.ds.REF_BASE.signInWithEmail(email, password: pwd, completion: nil)
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                                
                            }
                        })
                    }else if error?.code == STATUS_ACCOUNT_WRONG_PASSWORD {
                        self.showErrorAlert("Wrong password", msg: "The password entered is incorrect, please try again")
                    
                    }else{
                        self.showErrorAlert("something went wrong", msg: "can't log in")
                    }
                    
                }else{
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
            })
        }else{
            showErrorAlert("Email and password required", msg: "You must enter an email and a password")
        }
    }
    
    func showErrorAlert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil  )
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID)   != nil{
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

