//
//  AlbumDetailsSongsTableView.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 08.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit

class AlbumDetailsSongsTableView: UITableView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        register(UINib(nibName: "AlbumDetailsSongCell", bundle: nil), forCellReuseIdentifier: "AlbumDetailsSongCell")
        estimatedRowHeight = 20
        rowHeight = UITableViewAutomaticDimension
    }
}
