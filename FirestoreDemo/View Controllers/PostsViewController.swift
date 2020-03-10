import UIKit

class PostsViewController: UIViewController {
    
    // MARK: -IBOutlets
    
    @IBOutlet var postsTableView: UITableView!
    
    // MARK: -Internal Properties
    
    var posts = [Post]() {
        didSet {
            postsTableView.reloadData()
        }
    }
    
    // MARK: -Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.delegate = self
        postsTableView.dataSource = self
        loadPosts()
        postsTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPosts()
    }
    
    // MARK: - Private Methods
    
    private func loadPosts() {
        FirestoreService.manager.getPosts { [weak self] (result) in
            self?.handleFetchPostsResponse(withResult: result)
        }
    }
    
    private func handleFetchPostsResponse(withResult result: Result<[Post], Error>) {
        switch result {
        case let .success(posts):
            self.posts = posts
        case let .failure(error):
            print("An error occurred fetching the posts: \(error)")
        }
    }
}

// MARK: -Table View Delegate

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: -Table View Data Source

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostCell else {
            fatalError("could not downcast to PostCell")
        }
        let post = posts[indexPath.row]
        cell.configureCell(post: post)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let commentsStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let commentsVC = commentsStoryboard.instantiateViewController(identifier: "CommentsViewController") as? CommentsViewController else {
            return
        }
        commentsVC.post = post
        present(commentsVC, animated: true)
        
    }
}
