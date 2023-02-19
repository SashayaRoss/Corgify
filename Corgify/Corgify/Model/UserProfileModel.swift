//
//  UserProfileModel.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 03/02/2023.
//

import Foundation

struct UserProfileModel: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
//    let followers: [String: Codable]
    let id: String
    let images: [APIImage]
    let product: String
}
