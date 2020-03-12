import UIKit

class CreateNewPostViewController: UIViewController {
    
    // MARK: -IBOutlets
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyTextView.text = ""
        bodyTextView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    // MARK: -IBActions
    
    @IBAction func submitPost(_ sender: UIButton) {
        guard let title = titleTextField.text,
            let body = bodyTextView.text,
            let user = FirebaseAuthService.manager.currentUser,
            titleIsValid() && bodyIsValid() else {
            handleInvalidFields()
            return
        }
        
        let newPost = Post(title: title, body: body, userUID: user.uid)
        
        FirestoreService.manager.createPost(newPost) { [weak self] (result) in
            self?.handlePostResponse(withResult: result)
            self?.tabBarController?.selectedIndex = 0
            self?.bodyTextView.text = ""
            self?.titleTextField.text = ""
        }
    }
    
    // MARK: -Private Methods
    
    private func handlePostResponse(withResult result: Result<Void, Error>) {
        switch result {
        case .success:
            print("Post created")
        case let .failure(error):
            print("An error occurred creating the post: \(error)")
        }
    }
    
    private func handleInvalidFields() {
        //TODO: Handle invalid fields
    }
    
    private func titleIsValid() -> Bool {
        guard let title = titleTextField.text, !title.isEmpty else {
            return false
        }
        return true
    }
    private func bodyIsValid() -> Bool {
        //TODO: Validate body
        guard let body = bodyTextView.text, !body.isEmpty else {
            return false
        }
        return true
    }
}
