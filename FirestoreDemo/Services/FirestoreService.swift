import FirebaseFirestore
import FirebaseAuth

class FirestoreService {
    
    // MARK:- Static Properties
    
    static let manager = FirestoreService()
    
    // MARK:- Internal Properties
    
    func getPosts(onCompletion: @escaping (Result<[Post], Error>) -> Void) {
        db.collection("posts").getDocuments() { (querySnapshot, err) in
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
    
    func create(_ user: PersistedUser, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(user.uid).setData(user.fieldsDict) { err in
            if let err = err {
                onCompletion(.failure(err))
            } else {
                onCompletion(.success(()))
            }
        }
    }
    
    func create(_ post: Post, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("posts").document(post.uuidStr).setData(post.fieldsDict) { err in
            if let err = err {
                onCompletion(.failure(err))
            } else {
                onCompletion(.success(()))
            }
        }
    }
    func createComment(_ comment: Comment, onCompletion: @escaping (Result<Bool, Error>) -> Void ) {
        db.collection("comments").document(comment.uuidStr).setData(comment.fieldsDict) { (error) in
            if let error = error {
                onCompletion(.failure(error))
            } else {
                onCompletion(.success(true))
            }
        }
    }
    
    // MARK:- Private Properties
    
    private let db = Firestore.firestore()
}
