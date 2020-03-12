//
//  Comment.swift
//  FirestoreDemo
//
//  Created by casandra grullon on 3/10/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import Foundation
import Firebase

struct Comment {
    let commentText: String
    let createdDate: Timestamp
    let postId: String
    let commentedBy: String
}
extension Comment {
    
    init(_ dictionary: [String: Any]) {
        self.commentText = dictionary["commentText"] as? String ?? "no comment text"
        self.createdDate = dictionary["createdDate"] as? Timestamp ?? Timestamp(date: Date())
        self.postId = dictionary["postId"] as? String ?? "no post id"
        self.commentedBy = dictionary["commentedBy"] as? String ?? "no commenter name"
    }
}
