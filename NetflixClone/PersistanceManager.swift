//
//  PersistanceManager.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 3/14/24.
//

import Foundation
import CoreData

class PersistanceManager: ObservableObject {
    let container = NSPersistentContainer(name: "NetflixClone")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
