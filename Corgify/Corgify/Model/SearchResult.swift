//
//  SearchResult.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 26/03/2023.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case playlist(model: Playlist)
    case track(model: AudioTrack)
}
