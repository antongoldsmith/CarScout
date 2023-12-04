//
//  User.swift
//  CarScout
//
//  Created by Anton Goldsmith on 12/3/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var UserInfo = User(id: NSUUID().uuidString,
                               fullName: "John Doe",
                               email: "name@example.com")
}
