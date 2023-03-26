//
//  AllCategoriesResponse.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 26/03/2023.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
