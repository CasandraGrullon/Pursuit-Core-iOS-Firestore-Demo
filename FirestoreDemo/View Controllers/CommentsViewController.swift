//
//  CommentsViewController.swift
//  FirestoreDemo
//
//  Created by casandra grullon on 3/10/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")

    }

    func updateUI() {
        titleLabel.text = post?.title
        bodyLabel.text = post?.body
    }

    @IBAction func addCommentButtonPressed(_ sender: UIButton) {
    }
}
