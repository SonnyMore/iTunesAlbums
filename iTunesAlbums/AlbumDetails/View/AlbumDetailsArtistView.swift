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
    @IBOutlet weak var albumRelease: UILabel!
    @IBOutlet weak var songsCount: UILabel!
    
    func setupView(with album: AlbumEntity) {
        artistName.text = album.artistName
        albumTitle.text = album.collectionName
        if let formatedDate = formatDateString(from: album.releaseDate) {
            albumRelease.text = "\(formatedDate), \(album.country)"
        } else {
            albumRelease.text = album.country
        }
        songsCount.text = "\(album.trackCount) tracks"
    }
    
    private func formatDateString(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd MMM YYYY"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
