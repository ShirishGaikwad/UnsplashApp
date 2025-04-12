//
//  NetworkService.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//

import Foundation
/// A singleton service responsible for handling network requests to the Unsplash API.
class NetworkService {
    static let shared = NetworkService()
    private init() {}

    // Fetch photos based on a search query and page for pagination.
    func fetchPhotos(query: String, page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let urlString = "\(Constants.baseURL)\(Constants.randomEndpoint)?query=\(query)&page=\(page)&client_id=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
                return
            }

            do {
                let response = try JSONDecoder().decode(PhotoSearchResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Fetch a single random photo with optional filters (e.g., query, count).
    func fetchRandomPhoto(query: String? = nil, count: Int = 1, completion: @escaping (Result<[Photo], Error>) -> Void) {
        var urlString = "\(Constants.baseURL)photos/random?client_id=\(Constants.apiKey)&count=\(count)"
        
        // If a query filter is provided, add it to the URL.
        if let query = query {
            urlString += "&query=\(query)"
        }

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
                return
            }

            do {
                // Directly decode into an array of Photo objects
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(.success(photos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

