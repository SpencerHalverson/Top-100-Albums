//
//  ContentView.swift
//  SwiftUI Top 100
//
//  Created by Spencer Halverson on 7/3/20.
//  Copyright © 2020 Spencer Halverson. All rights reserved.
//

import SwiftUI

struct TopAlbumsList: View {

    @Binding var albums: [Album]
    @Binding var feed: AlbumFeed

    var body: some View {
        VStack {
            Picker("Feed Picker", selection: $feed, content: {
                ForEach(AlbumFeed.allCases, id: \.self, content: { Text($0.rawValue) })
            })
            .pickerStyle(SegmentedPickerStyle())
            .labelsHidden()
            .padding(.horizontal)

            ZStack {
                List {
                    ForEach(albums, id: \.id) { album in
                        NavigationLink(destination: AlbumDetailView(albumIndex: self.index(for: album), selectedAlbum: album)) {
                            AlbumRow(album: album, index: self.index(for: album))
                        }
                    }
                }
                
                if albums.isEmpty {
                    ActivityIndicator(label: "LOADING", style: .medium, axis: .horizontal)                    
                }
            }
        }
        .navigationBarTitle("Top 100")
    }

    ///The album index represents the position in the top 100 list
    private func index(for album: Album) -> Int {
        if let albumIndex = albums.firstIndex(where: { $0.id == album.id }) {
            return albumIndex + 1
        } else {
            return 0
        }
    }
}

struct AlbumRow: View {

    @ObservedObject private var imageManager = ImageManager()
    var album: Album
    var index: Int

    private var thumbnail: some View {
        imageManager
            .downloadedImage
            .map({ Image(uiImage: $0) })?
            .resizable()
            .aspectRatio(contentMode: .fill)
    }

    private var placeholder: some View {
        ZStack {
            Color.lightGray
            Text("#\(index)").font(.headline)
        }
    }

    var body: some View {
        HStack {

            ZStack {
                placeholder
                thumbnail
            }
            .frame(width: 45, height: 45)
            .cornerRadius(3)
            .shadow(radius: 2)

            VStack(alignment: .leading) {
                Text(album.name)
                    .font(.headline)
                    .lineLimit(1)

                Text(album.artistName)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 2)
        .padding(.horizontal, 8)
        .onAppear(perform: {
            self.imageManager.fetchImage(self.album.artworkUrl100)
        })
    }
}
