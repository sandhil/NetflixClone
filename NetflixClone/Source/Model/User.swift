//
//  User.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 3/14/24.
//

import Foundation
import CoreData

struct User: Codable {
    var firstName: String?
    var lastName: String?
    var userName: String?
    var password: String?
    
    func toManagedUser() -> ManagedUser {
        let user = ManagedUser()
        user.user_name = userName
        user.password = password
        user.first_name = firstName
        user.last_name = lastName
        return user
    }
}
