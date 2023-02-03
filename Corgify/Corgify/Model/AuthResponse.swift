//
//  AuthResponse.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 03/02/2023.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}
