//
//  ChatViewController.swift
//  parseChatApp
//
//  Created by Rageeb Mahtab on 3/14/19.
//  Copyright © 2019 Rageeb Mahtab. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {
    
     var chatMessages: [PFObject] = []
    
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var chatField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        messagesTableView.dataSource = self as UITableViewDataSource
        messagesTableView.rowHeight = UITableView.automaticDimension
        messagesTableView.estimatedRowHeight = 400
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.retrieveChatMessages), userInfo: nil, repeats: true)
        messagesTableView.reloadData()
        
    }
    
    
    
    @IBAction func didTapSendButton(_ sender: Any) {
        let newMessage = PFObject(className: "Messages")
        newMessage["text"] = chatField.text ?? ""
        newMessage["user"] = PFUser.current()
        newMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatField.text = ""
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    @objc func retrieveChatMessages() {
        let query = PFQuery(className: "Messages")
        query.addDescendingOrder("createdAt")
        query.limit = 20
        query.includeKey("user")
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                self.chatMessages = messages
                self.messagesTableView.reloadData()
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
//        let query = PFQuery(className:"Message")
//        query.includeKey("text")
//        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
//            if let error = error {
//                // Log details of the failure
//                print(error.localizedDescription)
//            } else if let objects = objects {
//                // The find succeeded.
//                print("Successfully retrieved \(objects.count) scores.")
//                // Do something with the found objects
//                for object in objects {
//                    print(object["text"] as Any)
//                    cell.messageLabel.text = object["text"] as? String
//                }
//            }
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let chatMessage = chatMessages[indexPath.row]
        cell.messageLabel.text = chatMessage["text"] as? String
        
        if let user = chatMessage["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        return cell
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
