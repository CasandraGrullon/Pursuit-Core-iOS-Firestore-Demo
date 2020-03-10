//
//  PostCell.swift
//  FirestoreDemo
//
//  Created by casandra grullon on 3/10/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PostCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    public func configureCell(post: Post) {
        //query user??
        usernameLabel.text = getUserInfo(userID: post.uuid)
        postTitleLabel.text = post.title
        postBodyLabel.text = post.body
        let date = Date()
        dateLabel.text = date.convertDate()
    }
    public func getUserInfo(userID: String) {
        let db = Firestore.firestore()
        let postsRef = db.collection("users")
        
        postsRef.document(userID).getDocument { (snapshot , error) in
            if let error = error {
                print("\(error)")
            } else if let snapshot = snapshot {
                guard let dictData = snapshot.data() else {
                    return
                }
                let user = PersistedUser(from: dictData)
                self.usernameLabel.text = "POSTED BY: \(user.email ?? "Annonymos")"
                print(user.email)
            }
        }
    }
}
extension Date {
    func convertDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
