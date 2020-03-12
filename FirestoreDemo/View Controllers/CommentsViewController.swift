//
//  CommentsViewController.swift
//  FirestoreDemo
//
//  Created by casandra grullon on 3/10/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CommentsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var post: Post?
    var comments = [Comment]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var fireService = FirestoreService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")

    }

    func updateUI() {
        titleLabel.text = post?.title
        bodyLabel.text = post?.body
    }
    private func postComment(commentText: String) {
        guard let post = post else {
            return
        }
        fireService.createComment(post: post, comment: commentText) { (result) in
            switch result {
            case .failure(let error):
                print("could not create comment \(error)")
            case .success:
                print("created a comment")
            }
        }

    }

    @IBAction func addCommentButtonPressed(_ sender: UIButton) {
        guard let commentText = commentTextField.text, !commentText.isEmpty else {
            return
        }
        postComment(commentText: commentText)
                
    }
}
