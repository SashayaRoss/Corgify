//
//  NewReleasesModel.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 19/02/2023.
//

import Foundation

struct NewReleasesModel: Codable {
    let albums: AlbumsModel
}

struct AlbumsModel: Codable {
    let items: [Album]
}

struct Album: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let id: String
    let images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
}
