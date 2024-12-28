//
//  Models.swift
//  Blu
//
//  Created by Aranza Manriquez Alonso on 25/12/24.
//

import Foundation

struct LoginRequest: Codable {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

struct LoginResponse: Codable {
    let token: String?
}

struct DogImageResponse: Codable {
    let message: String
    let status: String
}
