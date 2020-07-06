//
//  FeedManager.swift
//  SwiftUI Top 100
//
//  Created by Spencer Halverson on 7/3/20.
//  Copyright © 2020 Spencer Halverson. All rights reserved.
//

import Foundation
import Combine

enum AlbumFeed: String, CaseIterable {
    case apple = "Apple Music"
    case itunes = "iTunes Music"

    var url: String {
        switch self {
        case .itunes: return "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
        case .apple: return "https://rss.itunes.apple.com/api/v1/us/itunes-music/top-albums/all/100/explicit.json"
        }
    }
}

class FeedManager: ObservableObject {

    @Published var albums: [Album] = []
    @Published var error: String?
    @Published var selectedFeed: AlbumFeed {
        didSet {
            albums.removeAll()
            fetchAlbums()
        }
    }
    @Published var viewState: ViewState = .loading {
        didSet {
            switch viewState {
            case .loading: break
            case .failed(let error): self.error = error
            case .ready(let albums): self.albums = albums
            }
        }
    }

    private var tasks: Set<AnyCancellable> = []

    init(_ feed: AlbumFeed) {
        self.selectedFeed = feed
    }

    /// Instead of building an entire networking layer this is a single data task publisher to GET the album results
    func fetchAlbums() {
        
        guard let url = URL(string: selectedFeed.url) else {
            return error = "Invalid URL Provided"
        }

        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap({ $0.data })
            .decode(type: RSSFeedResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.viewState = .failed(error.localizedDescription)
                    print("---> Feed request finished with error \(error.localizedDescription)")
                case .finished:
                    print("---> Feed request completed successfully")
                }
            }, receiveValue: { feedResponse in
                self.viewState = .ready(feedResponse.feed.results)
            })
            .store(in: &tasks)
    }
}

extension String: Identifiable {
    public var id: UUID { return UUID() }
}
