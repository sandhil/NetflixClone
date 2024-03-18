import Foundation
import RxSwift
import Alamofire
import Swinject
import SwiftUI
import FirebaseFirestore
import CoreData

class LoginViewModel: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @Published var username: String = "sandhiltmdb"
    @Published var password: String = "@3SPde!Jj6HpA7y"
    
    var token = Constants.accessToken
    let disposeBag = DisposeBag()
    let backendClient: BackendClient!
    let persistanceContext: NSManagedObjectContext!
    
    init() {
        backendClient = Container.sharedContainer.resolve(BackendClient.self)
        persistanceContext = Container.sharedContainer.resolve(NSManagedObjectContext.self)
    }
    
    func login() {
        firebaseLogin()
        
    }
    
    func getToken() {
        requestToken()
            .subscribe(onSuccess: { [weak self] dataList in
                self?.isLoggedIn = true
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        
    }
    
    
    private func requestToken() -> Single<Movie> {
        let apiRequest: ApiRequest = ApiRequest(method: .get, endPoint: .requestToken, parameters: nil)
        return backendClient.load(request: apiRequest)
    }
    
    private func loginToTMDB() -> Single<[Movie]> {
        let apiRequest: ApiRequest = ApiRequest(method: .post, endPoint: .login, parameters: ["username": username, "password": password, "request_token": token])
        return backendClient.load(request: apiRequest)
    }
    
    func firebaseLogin() {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(username)
        
        docRef.getDocument { documentSnapshot, error in
            let user = documentSnapshot.flatMap {
                try? $0.data(as: User.self)
            }
            if user?.password == self.password {
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


extension ManagedUser {
    func toUser(user: User) {
        self.first_name = user.firstName
        self.last_name = user.lastName
        self.user_name = user.userName
        self.password = user.password
    }
}
