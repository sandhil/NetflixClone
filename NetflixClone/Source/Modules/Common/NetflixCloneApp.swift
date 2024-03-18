//
//  NetflixCloneApp.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 2/29/24.
//

import SwiftUI
import Swinject
import FirebaseCore
import CoreData

@main
struct NetflixCloneApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                TabBar()
            } else {
                Login()
            }
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}


extension Container {
    static var sharedContainer: Container = {
        let container = Container()
        let baseURL = Constants.baseURL
        let apiClient = ApiClient(baseURL: baseURL)
        
        container.register(BackendClient.self) { _ in
            BackendClient(apiClient: apiClient)
        }.inObjectScope(.container)
        
        container.register(NSManagedObjectContext.self) { _ in
            PersistanceManager().container.viewContext
        }
        return container
    }()
    
    
}
