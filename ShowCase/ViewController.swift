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

