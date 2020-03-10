//
//  CommentCell.swift
//  FirestoreDemo
//
//  Created by casandra grullon on 3/10/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit


class CommentCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    public func configureCell(comment: Comment ) {
        usernameLabel.text = comment.userId
        let date = Date()
        dateLabel.text = date.convertDate()
        commentLabel.text = comment.comment
    }
}
