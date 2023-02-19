//
//  PlaylistModel.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 03/02/2023.
//

import Foundation

//TODO: Fix naming in models

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
