//
//  ImageManager.swift
//  SwiftUI Top 100
//
//  Created by Spencer Halverson on 7/3/20.
//  Copyright © 2020 Spencer Halverson. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

///Initialize once per image view
class ImageManager: ObservableObject {

    @Published var downloadedImage: UIImage?

    private static var cache = NSCache<NSString, UIImage>()
    private var downloadTask: AnyCancellable?

    func fetchImage(_ imageUrl: String) {

        if let cachedImage = ImageManager.cache.object(forKey: NSString(string: imageUrl)) {
            downloadedImage = cachedImage

        } else if let url = URL(string: imageUrl) {

            downloadTask = URLSession.shared
                .dataTaskPublisher(for: url)
                .compactMap({ UIImage(data: $0.data) })
                .eraseToAnyPublisher()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { result in
                    switch result {
                    case .finished: break
                    case .failure(let error):
                        print("--> Image failed to download with error \(error.localizedDescription) ")
                    }
                }, receiveValue: { image in
                    ImageManager.cache.setObject(image, forKey: NSString(string: imageUrl))
                    self.downloadedImage = image
                })
        }
    }

    static func cachedImage(_ imageUrl: String) -> UIImage? {
        ImageManager.cache.object(forKey: NSString(string: imageUrl))
    }
}
