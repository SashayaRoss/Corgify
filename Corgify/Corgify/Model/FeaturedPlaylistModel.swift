//
//  FeaturedPlaylistModel.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 19/02/2023.
//

struct FeaturedPlaylistModel: Codable {
    let message: String
    let playlists: PlaylistModel
}

struct CategoryPlaylistModel: Codable {
    let playlists: PlaylistModel
}

struct PlaylistModel: Codable {
    let items: [Playlist]
}
