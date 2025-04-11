//
//  ImageCache.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//


import UIKit

/// A singleton class to handle image caching for better performance and reduced network usage.
class ImageCache {
    static let shared = ImageCache() // Shared instance for global access.
    private let cache = NSCache<NSString, UIImage>() // NSCache for storing images.

    private init() {} // Private initializer to ensure singleton usage.
    
    /// Retrieves an image from the cache for the specified key.
    /// - Parameter key: The unique identifier for the cached image.
    /// - Returns: The cached `UIImage` if available, otherwise `nil`.
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    /// Saves an image to the cache with the specified key.
    /// - Parameters:
    ///   - image: The `UIImage` to be cached.
    ///   - key: The unique identifier for the image.
    func saveImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
