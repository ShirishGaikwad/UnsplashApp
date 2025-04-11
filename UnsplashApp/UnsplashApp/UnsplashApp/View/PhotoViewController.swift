//
//  PhotoViewController.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//

import UIKit

// ViewController responsible for displaying a grid of photos.
class PhotoViewController: UIViewController {
    private let viewModel = PhotoViewModel()
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBindings()
        viewModel.fetchPhotos(query: "nature") // Fetch initial set of photos.
    }

    // Sets up the collection view.
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }

    // Sets up bindings between the ViewModel and ViewController.
    private func setupBindings() {
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension PhotoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Returns the number of items in the collection view.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    // Configures each cell in the collection view.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = viewModel.photo(at: indexPath.item)
        cell.configure(with: photo)
        return cell
    }
    
    // Handles cell selection.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photo(at: indexPath.item)
        let detailVC = PhotoDetailViewController()
        detailVC.photo = photo
        navigationController?.pushViewController(detailVC, animated: true)
    }

    // Sets the size of each item in the collection view.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 // Padding between items.
        let availableWidth = collectionView.frame.width - (padding * 3) // Calculate available width for 3 items per row.
        let width = availableWidth / 3
        return CGSize(width: width, height: width + 30) // Adjust height for thumbnails and spacing.
    }
}

//extension PhotoViewController: UIScrollViewDelegate {
//    // Detects when the user scrolls near the bottom and loads more photos.
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let frameHeight = scrollView.frame.size.height
//
//        if offsetY > contentHeight - frameHeight * 2 {
//            viewModel.loadMorePhotos(query: "nature")
//        }
//    }
//}

extension PhotoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        // Trigger loading when near the bottom
        if offsetY > contentHeight - frameHeight * 2 {
            viewModel.loadMorePhotos(query: "latest")
        }
    }
}
