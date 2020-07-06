//
//  BaseNavigationView.swift
//  SwiftUI Top 100
//
//  Created by Spencer Halverson on 7/3/20.
//  Copyright © 2020 Spencer Halverson. All rights reserved.
//

import SwiftUI

struct BaseNavigationView: View {

    @ObservedObject private var viewModel = FeedManager(.apple)

    init() {
        UINavigationBar.appearance().tintColor = .black
    }

    ///Shows the list of albums and the detail album view in a master detail relationship on ipad and stacked on iphone
    var body: some View {
        NavigationView {
            Group {
                TopAlbumsList(albums: $viewModel.albums, feed: $viewModel.selectedFeed)
                    .animation(.easeIn)

                showAlbumDetail()
            }
        }
        .onAppear(perform: viewModel.fetchAlbums)
        .alert(item: $viewModel.error, content: { error in
            Alert(title: Text(error))
        })
    }

    ///SwiftUI view builder does not allow unwrapping optionals within a content view so it must be handled in a separate function
    private func showAlbumDetail() -> some View {
        if let firstAlbum = viewModel.albums.first {
            return AnyView(AlbumDetailView(albumIndex: 0, selectedAlbum: firstAlbum))

        } else {
            return AnyView(Text("SELECT ALBUM FROM LIST"))
        }
    }
}
