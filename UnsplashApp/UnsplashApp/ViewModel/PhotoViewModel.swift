//
//  PhotoViewModel.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//

import Foundation

// ViewModel responsible for managing and fetching photo data.
class PhotoViewModel {
    private var photos: [Photo] = [] // Array to store fetched photos.
    private var currentPage = 1 // Current page number for pagination.
    private var isFetching = false // Indicates whether data is being fetched.
    
    // Closure to notify the view controller to reload the collection view.
    var reloadCollectionView: (() -> Void)?
    
    // Returns the number of photos currently loaded.
    var numberOfItems: Int {
        return photos.count
    }

    // Returns the photo at a specific index.
    func photo(at index: Int) -> Photo {
        return photos[index]
    }

    // Fetches photos from the Unsplash API for a specific query and page.
    func fetchPhotos(query: String, page: Int = 1) {
        guard !isFetching else { return } // Prevent multiple simultaneous fetches.
        isFetching = true
        
        let queryWithPage = "\(query)&page=\(page)" // Append page number to the query.
        NetworkService.shared.fetchPhotos(query: queryWithPage) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            
            switch result {
            case .success(let newPhotos):
                if page == 1 {
                    self.photos = newPhotos // Replace existing photos on a new search.
                } else {
                    self.photos.append(contentsOf: newPhotos) // Append new photos for pagination.
                }
                self.currentPage = page
                self.reloadCollectionView?() // Notify the view to reload.
            case .failure(let error):
                print("Error fetching photos: \(error.localizedDescription)") // Log error.
            }
        }
    }

    // Loads more photos when the user scrolls near the bottom of the collection view.
    func loadMorePhotos(query: String) {
        fetchPhotos(query: query, page: currentPage + 1)
    }
}
