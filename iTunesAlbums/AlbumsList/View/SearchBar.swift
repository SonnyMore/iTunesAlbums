//
//  AlbumsListSearchBar.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit

class AlbumsListSearchBar: UISearchBar {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBar()
    }
    
    private func setupBar() {
        self.placeholder = "Название альбома"
        self.searchBarStyle = .minimal
    }
}
