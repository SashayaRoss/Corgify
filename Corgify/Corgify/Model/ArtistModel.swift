//
//  ArtistModel.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 03/02/2023.
//


struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}
