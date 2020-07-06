//
//  AlbumDetailView.swift
//  SwiftUI Top 100
//
//  Created by Spencer Halverson on 7/3/20.
//  Copyright © 2020 Spencer Halverson. All rights reserved.
//

import SwiftUI

struct AlbumDetailView: View {

    var albumIndex: Int
    var selectedAlbum: Album

    private var infoButton: some View {
        ZStack {
            Color.white
                .shadow(color: .lightGray, radius: 2, x: 0, y: -2)
                .frame(height: 85)

            Button(action: didTapViewAlbum, label: {
                Text("View Album").bold()
                    .frame(maxWidth: .infinity, maxHeight: 45)
                    .background(Color.itunesGradient)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(20)
            })
        }
    }

    private var albumInformation: some View {
        ScrollView {
            ImageManager.cachedImage(selectedAlbum.artworkUrl100)
                .map({ Image(uiImage: $0) })?
                .resizable()
                .frame(maxWidth: 500, maxHeight: 500)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(7)
                .shadow(radius: 4)
                .padding()

            Text(selectedAlbum.name)
                .font(.headline)
                .fontWeight(.heavy)
                .padding(.horizontal)
                .multilineTextAlignment(.center)

            VStack {
                LabelPair(title: "Artist", value: selectedAlbum.artistName)
                Divider()
                LabelPair(title: "Genre", value: selectedAlbum.genres.map({ $0.name }).joined(separator: ", "))
                Divider()
                LabelPair(title: "Release Date", value: selectedAlbum.releaseDate)
                Divider()
                LabelPair(title: "Copyright", value: selectedAlbum.copyright)
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding()
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            albumInformation
            infoButton
        }
        .navigationBarTitle("#\(albumIndex)", displayMode: .inline)
    }

    private func didTapViewAlbum() {
        guard
            let albumUrl = URL(string: selectedAlbum.url),
            UIApplication.shared.canOpenURL(albumUrl) else {
            print("INVALID ALBUM URL")
            return
        }

        UIApplication.shared.open(albumUrl, options: [:], completionHandler: { success in
            print("DID OPEN ALBUM URL: \(success)")
        })
    }
}

private struct LabelPair: View {

    var title: String
    var value: String

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Text(title).bold()
            Spacer()
            Text(value).multilineTextAlignment(.trailing)
        }
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(albumIndex: 1, selectedAlbum: Album(artistName: "", id: "", releaseDate: "", name: "", kind: "", copyright: "", artistId: "", contentAdvisoryRating: "", artistUrl: "", artworkUrl100: "", genres: [], url: ""))
    }
}
