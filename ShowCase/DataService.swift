//
//  DataService.swift
//  ShowCase
//
//  Created by david johnson on 2016/10/22.
//  Copyright © 2016 hiddenplatform. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = FIRAuth.auth()!
        
    var REF_BASE: FIRAuth{
        return _REF_BASE
    }
    

    
}