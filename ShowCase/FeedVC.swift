//
//  FeedVC.swift
//  ShowCase
//
//  Created by david johnson on 2016/10/23.
//  Copyright © 2016 hiddenplatform. All rights reserved.
//

import UIKit
import Firebase
import Alamofire


class FeedVC: UIViewController, UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postField: MaterialTextField!
    @IBOutlet weak var imageSelectorImg: UIImageView!

    
    var posts = [Post]()
    
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
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
        print(post.imageURL)
        print(post.likes)
        print(post.postDescription)

        
        return tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageSelectorImg.image = image
    }
    
    @IBAction func selectImage(sender: UITapGestureRecognizer) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
   
    @IBAction func makePost(sender: AnyObject) {
        if let txt = postField.text where txt != "" {
            if let img = imageSelectorImg.image where imageSelectorImg.image != "camera" {
                let urlStr = "https://post.imageshack.us/upload_api.php"
                let url = NSURL(string: urlStr)!
                let imageData = UIImageJPEGRepresentation(img, 0.2)!
                let keyData = "3567EGJX4943b916a0a5b3ed101a283efb085e79".dataUsingEncoding(NSUTF8StringEncoding)!
                let keyJson = "json".dataUsingEncoding(NSUTF8StringEncoding)!
                
                 Alamofire.upload(.POST, url, multipartFormData: { MultipartFormData in
                    MultipartFormData.appendBodyPart(data: imageData, name: "fileupload", fileName: "image", mimeType: "image/jpg")
                    MultipartFormData.appendBodyPart(data: keyData, name: "key")
                    MultipartFormData.appendBodyPart(data: keyJson, name: "format")
                    
                 }) { encodingResult in
                 
                    switch encodingResult {
                    case  .Success(let upload, _,_):
                        upload.responseJSON(completionHandler: {result in
                            if let info = result.result.value as? Dictionary<String,AnyObject> {
                                if let links = info["links"] as? Dictionary<String,AnyObject> {
                                    if let imgLink = links["image_link"] as? String {
                                        print(imgLink)
                                    }
                                }
                            }
                            
                        })
                    
                    
                    
                    case .Failure(let error):
                        print(error)
                    }
                }
                
            }
        }
        
    }
   
}
