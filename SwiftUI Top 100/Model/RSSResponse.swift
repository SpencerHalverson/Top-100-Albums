//
//  RSSResponse.swift
//  SwiftUI Top 100
//
//  Created by Spencer Halverson on 7/3/20.
//  Copyright © 2020 Spencer Halverson. All rights reserved.
//

import Foundation

struct RSSFeedResponse: Decodable {
    var feed: RSSResults
}

struct RSSResults: Decodable {
    var results: [Album]
}
