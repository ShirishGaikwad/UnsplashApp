//
//  NetworkService.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//



import Foundation

/// A singleton service responsible for handling network requests to the Unsplash API.
class NetworkService {
    static let shared = NetworkService() // Shared instance for global access.
    
    private init() {} // Private initializer to ensure singleton usage.
    
    /// Fetches photos from the Unsplash API based on the provided search query.
    /// - Parameters:
    ///   - query: The search term for fetching photos.
    ///   - completion: Completion handler with the result, either an array of `Photo` objects or an error.
    func fetchPhotos(query: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        // Construct the API URL with base URL, endpoint, and query parameters.
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.searchEndpoint)?query=\(query)&client_id=\(Constants.apiKey)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil))) // Return error if URL is invalid.
            return
        }

        // Perform the API request using URLSession.
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle network-level errors.
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure data is not nil; otherwise, return an error.
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
                return
            }
            
            // Decode the JSON response into `PhotoSearchResponse`.
            do {
                let response = try JSONDecoder().decode(PhotoSearchResponse.self, from: data)
                completion(.success(response.results)) // Return the list of photos.
            } catch {
                completion(.failure(error)) // Handle JSON decoding errors.
            }
        }.resume() // Start the network request.
    }
}
