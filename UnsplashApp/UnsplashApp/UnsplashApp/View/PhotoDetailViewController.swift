//
//  PhotoDetailViewController.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//

import UIKit


class PhotoDetailViewController: UIViewController {
    var photo: Photo?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center // Center the text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center // Center the text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureView()
    }
    
    private func setupUI() {
        // Add the stack view and configure its layout
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            // Center stack view within the parent view
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Set a fixed height for the image
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func configureView() {
        if let photo = photo {
            titleLabel.text = photo.title ?? "Untitled"
            descriptionLabel.text = photo.description ?? "No description available."
            
            if let photoUrl = URL(string: photo.urls.full) {
                URLSession.shared.dataTask(with: photoUrl) { data, _, _ in
                    if let data = data {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        }
    }
}

