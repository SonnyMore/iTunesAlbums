//
//  AlbumsListCollectionViewCell.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumsListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(with album: AlbumEntity) {
        albumTitle.text = album.artistName
        albumSubtitle.text = album.collectionName
        guard let albumImageUrl = URL(string: album.artworkUrl100) else {
            albumImageView.image = #imageLiteral(resourceName: "albumPlaceholder")
            return
        }
        albumImageView.kf.setImage(with: albumImageUrl, placeholder: #imageLiteral(resourceName: "albumPlaceholder"), options: [.transition(.fade(0.6))], progressBlock: nil, completionHandler: nil)
    }
}
