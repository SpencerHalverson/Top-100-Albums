//
//  Album.swift
//  SwiftUI Top 100
//
//  Created by Spencer Halverson on 7/3/20.
//  Copyright © 2020 Spencer Halverson. All rights reserved.
//

import Foundation

// MARK: - Album
struct Album: Decodable {
    let artistName: String
    let id: String
    let releaseDate: String
    let name: String
    let kind: String
    let copyright: String
    let artistId: String
    let contentAdvisoryRating: String?
    let artistUrl: String
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
}

// MARK: - Genre
struct Genre: Decodable {
    let genreId: String
    let name: String
    let url: String
}
