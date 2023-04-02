//
//  LibraryAlbumsResponse.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 02/04/2023.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}
struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
