import Foundation
import FirebaseAuth

struct PersistedUser {
    let name: String?
    let email: String?
    let uid: String
    
    init(from user: User) {
        self.name = user.displayName
        self.email = user.email
        self.uid = user.uid
    }
    
    var fieldsDict: [String: Any] {
        return [
            "name": name ?? "",
            "email": email ?? ""
        ]
    }
}
extension PersistedUser {
    init?(from dict: [String: Any]) {
        guard let name = dict["name"] as? String,
        let email = dict["email"] as? String,
            let uid = dict["uid"] as? String else {
                return nil
        }
        self.name = name
        self.email = email
        self.uid = uid
    }

}
