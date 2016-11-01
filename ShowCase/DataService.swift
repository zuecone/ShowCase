//
//  DataService.swift
//  ShowCase
//
//  Created by david johnson on 2016/10/22.
//  Copyright © 2016 hiddenplatform. All rights reserved.
//

import Foundation
//import Firebase
import FirebaseAuth
import FirebaseDatabase

//let BASE_URL = "https://socialshowcase-f44a1.firebaseio.com"


class DataService {
    static let ds = DataService()
    
    
//    private var _BASE_REF = FIRDatabaseReference().child(BASE_URL)
//    private var _USER_REF = FIRDatabaseReference().child("\(BASE_URL)/users")
//    private var _POST_REF = FIRDatabaseReference().child("\(BASE_URL)/posts")
    
    private var _REF_BASE = FIRAuth.auth()!
    
    private var _REF_POSTS = FIRDatabase.database().reference().child("posts")
    private var _REF_USERS = FIRDatabase.database().reference().child("users")
    
    var REF_BASE: FIRAuth{
        return _REF_BASE
    }

    var REF_USERS: FIRDatabaseReference{
        return _REF_USERS
    }
    
    var REF_POSTS: FIRDatabaseReference{
        return _REF_POSTS
    }
    
    
//    var REF_DB: FIRDatabaseReference{
//        _REF_DB = FIRDatabase.database().reference()
//        return _REF_DB
//    }

    
    func createFirebaseUser(uid: String,user: Dictionary<String,String>){
        REF_USERS.child(uid).setValue(user)
    }
    
        
}