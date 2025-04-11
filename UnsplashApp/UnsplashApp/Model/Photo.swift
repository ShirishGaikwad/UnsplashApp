//
//  Photo.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//

import Foundation

// Represents the response structure from the Unsplash API for a photo search request.
struct PhotoSearchResponse: Codable {
    let results: [Photo] // Array of photos returned from the search query.
}

// Represents an individual photo object.
struct Photo: Codable {
    let id: String // Unique identifier for the photo.
    let urls: PhotoURLs // URLs for different image sizes.
    let description: String? // Optional description of the photo.
}

// Represents the different image URLs for a photo.
struct PhotoURLs: Codable {
    let small: String // URL for the small-sized image.
    let full: String // URL for the full-sized image.
}
struct PhotoResponse: Codable {
    let results: [Photo]
}
