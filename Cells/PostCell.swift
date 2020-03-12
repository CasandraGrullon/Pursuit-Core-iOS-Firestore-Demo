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
        let userID = post.userUID
        usernameLabel.text = getUserInfo(userID: userID)
        postTitleLabel.text = post.title
        postBodyLabel.text = post.body
        let date = Date()
        dateLabel.text = date.convertDate()
    }
    public func getUserInfo(userID: String) -> String {
        let db = Firestore.firestore()
        let postsRef = db.collection("users")
        var email = String()
        postsRef.document(userID).getDocument { (snapshot , error) in
            if let error = error {
                print("\(error)")
            } else if let snapshot = snapshot {
                guard let dictData = snapshot.data() else {
                    return
                }
                guard let user = PersistedUser(from: dictData), let userEmail = user.email else {
                    return
                }
                email = userEmail
                
            }
        }
        return email
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
