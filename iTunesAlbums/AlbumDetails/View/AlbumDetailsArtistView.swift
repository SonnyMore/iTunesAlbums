//
//  AlbumDetailsArtistView.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 08.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit

class AlbumDetailsArtistView: UIView {
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var songsCount: UILabel!
    
    func setupView(with album: AlbumEntity) {
        artistName.text = album.artistName
        albumTitle.text = album.collectionName
        songsCount.text = "\(album.trackCount) tracks"
    }
}
