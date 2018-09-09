//
//  AlbumsListView.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit

class AlbumsListView: UIView {
    @IBOutlet weak var searchBar: AlbumsListSearchBar!
    @IBOutlet weak var collectionView: AlbumsListCollectionView!
    
    //searchBar & CollectionView delegate
    private var delegate: (AlbumsListViewSearchDelegate & AlbumsListViewCollectionDelegate)?
    private var albums = [AlbumEntity]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setDelegate(delegate: AlbumsListViewSearchDelegate & AlbumsListViewCollectionDelegate) {
        self.delegate = delegate
    }
    
    //update UI when albums were updated
    func updateData(data: [AlbumEntity]) {
        self.albums = data
        self.collectionView.setContentOffset(.zero, animated: false)
        self.collectionView.reloadData()
    }
}

extension AlbumsListView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didSearchBarButtonPressed(text: searchBar.text!)
        endEditing(true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.didSearchBarBeginEditing()
        searchBar.showsCancelButton = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        delegate?.didSearchBarEndEditing()
        searchBar.showsCancelButton = false
    }
}

extension AlbumsListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = albums.count
        if (count == 0 && !searchBar.text!.isEmpty) {
            collectionView.backgroundView = collectionView.emptyResultBackgroundView()
        } else {
            collectionView.backgroundView = nil
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumsListCollectionViewCell", for: indexPath) as! AlbumsListCollectionViewCell
        cell.setupCell(with: albums[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width/3-15, height: 220)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        delegate?.didAlbumSelected(album: album)
    }
}
