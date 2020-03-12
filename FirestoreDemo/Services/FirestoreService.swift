import FirebaseFirestore
import FirebaseAuth

class FirestoreService {
    
    // MARK:- Static Properties
    
    static let manager = FirestoreService()
    static let usersCollection = "users"
    static let postsCollection = "posts"
    static let commentsCollection = "comments"
    
    // MARK:- Internal Properties
    
    func getPosts(onCompletion: @escaping (Result<[Post], Error>) -> Void) {
        db.collection(FirestoreService.postsCollection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                onCompletion(.failure(err))
            } else {
                let posts = querySnapshot!.documents.compactMap { (snapShot) -> Post? in
                    guard let uuid = UUID(uuidString: snapShot.documentID) else { return nil }
                    return Post(from: snapShot.data(), andUUID: uuid)
                }
                onCompletion(.success(posts))
            }
        }
    }
    
    func createUser(_ user: PersistedUser, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(FirestoreService.usersCollection).document(user.uid).setData(user.fieldsDict) { err in
            if let err = err {
                onCompletion(.failure(err))
            } else {
                onCompletion(.success(()))
            }
        }
    }
    
    func createPost(post: Post, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let docRef = db.collection(FirestoreService.usersCollection).document(user.uid).collection(FirestoreService.postsCollection).document()
        
        db.collection(FirestoreService.usersCollection).document(user.uid).collection(FirestoreService.postsCollection).document(docRef.documentID).setData(post.fieldsDict) { (error) in
            if let error = error {
                onCompletion(.failure(error))
            } else {
                onCompletion(.success(()))
            }
        }
        
    }
    func createComment(post: Post, comment: String ,onCompletion: @escaping (Result<Void, Error>) -> Void ) {
       
        guard let user = Auth.auth().currentUser, let email = user.email else {
            return
        }
        let docRef = db.collection(FirestoreService.usersCollection).document(user.uid).collection(FirestoreService.postsCollection).document(post.uuidStr).collection(FirestoreService.commentsCollection).document()
        
        db.collection(FirestoreService.usersCollection).document(user.uid).collection(FirestoreService.postsCollection).document(post.uuidStr).collection(FirestoreService.commentsCollection).document(docRef.documentID).setData(["commentText": comment, "createdDate": Timestamp(date: Date()), "postId": post.uuidStr, "commentedBy": email]) { (error) in
            if let error = error {
                onCompletion(.failure(error))
            } else {
                onCompletion(.success(()))
            }
        }
        
        
    }
    
    // MARK:- Private Properties
    
    private let db = Firestore.firestore()
}
