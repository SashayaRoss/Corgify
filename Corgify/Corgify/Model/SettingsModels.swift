//
//  SettingsModels.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 12/02/2023.
//

struct Section {
    let title: String
    let option: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
