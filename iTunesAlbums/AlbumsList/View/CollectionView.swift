//
//  AlbumsListCollectionView.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit

class AlbumsListCollectionView: UICollectionView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        register(UINib(nibName: "AlbumsListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AlbumsListCollectionViewCell")
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 5
        layout.invalidateLayout()
        collectionViewLayout = layout
    }
}
