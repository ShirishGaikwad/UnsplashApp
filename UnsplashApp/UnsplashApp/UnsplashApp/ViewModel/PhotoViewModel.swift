//
//  PhotoViewModel.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//

import Foundation
/// ViewModel responsible for managing and fetching photo data.
/// - Handles data binding between the view and model.
/// - Fetches photos using `NetworkService`.
/// - Supports pagination and triggers UI reloads.
class PhotoViewModel {
    private var photos: [Photo] = [] // Array of fetched photos.
        private var currentPage = 1 // Current page for pagination.
        private var isFetching = false // Indicates if a fetch operation is in progress.

        var reloadCollectionView: (() -> Void)? // Callback to reload the collection view.

        /// The number of photos available.
        var numberOfItems: Int {
            return photos.count
        }

        /// Fetches a specific photo by its index.
        /// - Parameter index: Index of the photo in the array.
        /// - Returns: The `Photo` object at the specified index.
    func photo(at index: Int) -> Photo {
        return photos[index]
    }
    /// Fetches photos from the Unsplash API based on a search query.
    /// - Parameters:
    ///   - query: The search term.
     ///   - page: Page number for pagination (default is 1).
    func fetchPhotos(query: String, page: Int = 1) {
        guard !isFetching else { return }
        isFetching = true
        
        NetworkService.shared.fetchPhotos(query: query, page: page) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            
            switch result {
            case .success(let newPhotos):
                if page == 1 {
                    self.photos = newPhotos
                } else {
                    self.photos.append(contentsOf: newPhotos)
                }
                self.currentPage = page
                self.reloadCollectionView?()
            case .failure(let error):
                print("Error fetching photos: \(error.localizedDescription)")
            }
        }
    }
    /// Loads more photos for infinite scrolling.
   /// - Parameter query: The search term.
    func loadMorePhotos(query: String) {
        fetchPhotos(query: query, page: currentPage + 1)
    }
}

