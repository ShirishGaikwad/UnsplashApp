//
//  ImageCache.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//

import UIKit

/// A singleton class to handle image caching for better performance and reduced network usage.
class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func saveImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

