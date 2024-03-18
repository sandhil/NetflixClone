import Foundation
import RxSwift
import Alamofire
import Swinject
import SwiftUI
import FirebaseFirestore
import CoreData

class SingupViewModel: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    
    
    var token = Constants.accessToken
    let disposeBag = DisposeBag()
    let backendClient: BackendClient!
    let persistanceContext: NSManagedObjectContext!
    
    init() {
        backendClient = Container.sharedContainer.resolve(BackendClient.self)
        persistanceContext = Container.sharedContainer.resolve(NSManagedObjectContext.self)
    }
    
    func signup() {
        firebaseSignup()
        
    }
    
    func firebaseSignup() {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(username)
        let user = User(firstName: firstName, lastName: lastName, userName: username, password: password)
        docRef.setData(user.toDictionary()) { error in
            if error == nil {
                self.persistUser(user: user)
                self.isLoggedIn = true
            }
        }
        
        
    }
    
    func persistUser(user: User) {
        let managedUser = ManagedUser(context: persistanceContext)
        managedUser.toUser(user: user)
        try? persistanceContext.save()
    }
}
