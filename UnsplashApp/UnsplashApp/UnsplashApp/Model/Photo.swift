//
//  Photo.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//

import Foundation

/// Represents a single photo from the Unsplash API.
//  PhotoSearchResponse.swift
//  UnsplashApp

import Foundation

// Represents the response structure for the photo search request or random photo.
struct PhotoSearchResponse: Codable {
    let results: [Photo] // Array of photos (for search queries).
}

// The structure representing a single photo.
// Represents an individual photo object.
struct Photo: Codable {
    let id: String
    let urls: PhotoURLs
    let description: String?  // Optional description of the photo.
    let title: String?  // Optional title of the photo.
}


// Represents various resolutions for a photo.
struct PhotoURLs: Codable {
    let small: String // URL for a small version of the photo.
    let full: String // URL for a full-resolution version of the photo.
}
