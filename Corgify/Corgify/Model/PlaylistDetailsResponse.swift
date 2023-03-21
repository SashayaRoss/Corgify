//
//  PlaylistDetailsResponse.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 21/03/2023.
//

import Foundation

struct PlaylistDetailsResponse: Codable {
    let description: String?
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let `public`: Bool
    let tracks: PlaylistTracksResponse
}

struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}
