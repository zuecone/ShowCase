//
//  FeedVC.swift
//  ShowCase
//
//  Created by david johnson on 2016/10/23.
//  Copyright © 2016 hiddenplatform. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: {snapshot in
//            print(snapshot.value)
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                //clear out when new data appears
                self.posts = []
                for snap in snapshot {
                    //print("SNAP: \(snap)")
                    
                    //this section gets all of the data from the posts object in firebase.
                    //below also then converts the key value and then passes the dictionary to the POST class and then unwraps it.
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })

        // Do any additional setup after loading the view.
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        print(post.postDescription)
        
        return tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
    }
    
    
   
   
}
