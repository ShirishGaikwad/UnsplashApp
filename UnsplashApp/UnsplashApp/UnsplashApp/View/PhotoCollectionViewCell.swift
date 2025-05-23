//
//  PhotoCollectionViewCell.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//
import UIKit


// Custom UICollectionViewCell to display photo thumbnails.
class PhotoCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // Maintains the image's aspect ratio.
        imageView.clipsToBounds = true // Ensures image stays within bounds.
               return imageView
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up constraints for the image view to fill the cell.
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configures the cell with a photo object.
       /// - Parameter photo: The `Photo` object containing the image URL.
       func configure(with photo: Photo) {
           loadImage(from: photo.urls.small)
       }
       
       /// Loads an image from a URL and caches it.
       /// - Parameter url: URL string of the image.
    
    private func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        // Check if the image is cached.
        if let cachedImage = ImageCache.shared.getImage(forKey: url) {
            self.imageView.image = cachedImage
            return
        }
        
        // Fetch the image from the network if not cached.
        URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
            guard let self = self, let data = data, let image = UIImage(data: data) else { return }
            
            // Cache the fetched image.
            ImageCache.shared.saveImage(image, forKey: url)
            
            // Update the UI on the main thread.
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }.resume()
    }
}

