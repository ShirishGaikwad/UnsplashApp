# UnsplashApp
UnsplashApp is an iOS application that fetches and displays high-quality photos from the Unsplash API. The app features a grid layout powered by UICollectionView and implements asynchronous image fetching and caching without using any third-party libraries.
Features
 Grid Layout: Photos are displayed in a clean and responsive grid layout.
Asynchronous Image Fetching: Images are fetched from the Unsplash API without blocking the main thread. 
Image Caching: Downloaded images are cached to optimize performance and reduce network calls.
No Third-Party Libraries: The app is built using only native iOS frameworks such as UIKit and Foundation.
How It Works
 Fetching Images:The app communicates with the Unsplash API using URLSession to fetch images.
 Displaying Images:
Images are displayed in a grid layout using UICollectionView.
Each cell is dynamically configured with photo data.
Image Caching:
The app implements a custom caching mechanism to store images in memory,
 Technical Details 
Architecture:MVVM (Model-View-ViewModel) architecture is used for clean separation of concerns and testability.
Programming Language: Swift.
Key Classes:
PhotoViewController: Handles the UICollectionView and user interactions.
PhotoViewModel: Manages API calls, data processing, and pagination logic.
PhotoCollectionViewCell: Custom UICollectionViewCell for displaying images.
ImageCache: Provides an in-memory caching layer for images.
NetworkService: Handles network requests and API communication.
Constants:
The app uses static constants for the base URL, API key, and query parameters to keep the code clean and modular.
Setup Instructions :
Clone the repository to your local machine.
Open the project in Xcode.
Replace the placeholder Unsplash API key in Constants.swift with your own API key:
swift Copy Edit static let apiKey = "YourAPIKey" 
Build and run the app on a simulator or a real device.
Limitations 
Currently, the app uses only the Unsplash open API and does not include advanced features like photo search.
The app does not include error handling for API rate limits or connectivity issues.
