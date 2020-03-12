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
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, h:mm a"
        return formatter
    }()
    
    public func configureCell(comment: Comment) {
        usernameLabel.text = comment.commentedBy
        let date = comment.createdDate.dateValue()
        dateLabel.text = dateFormatter.string(from: date)
        commentLabel.text = comment.commentText
    }
}
