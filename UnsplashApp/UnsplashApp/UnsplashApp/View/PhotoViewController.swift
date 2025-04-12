//
//  PhotoViewController.swift
//  UnsplashApp
//
//  Created by shirish gayakawad on 11/04/25.
//

//  PhotoViewController.swift
//  UnsplashApp

import UIKit

class PhotoViewController: UIViewController {
    private let viewModel = PhotoViewModel()
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBindings()
        viewModel.fetchPhotos(query: "nature")
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }

    private func setupBindings() {
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}
// Data source and delegate methods for the photo collection.

extension PhotoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = viewModel.photo(at: indexPath.item)
        cell.configure(with: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photo(at: indexPath.item)
        let detailVC = PhotoDetailViewController()
        detailVC.photo = photo
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let availableWidth = collectionView.frame.width - (padding * 3)
        let width = availableWidth / 3
        return CGSize(width: width, height: width + 30)
    }
}

