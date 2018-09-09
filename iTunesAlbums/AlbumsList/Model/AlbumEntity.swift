//
//  AlbumEntity.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import Foundation

struct AlbumEntity: Serializable {
    var artistName: String
    var artworkUrl100: String
    var collectionId: Int
    var collectionName: String
    var trackCount: Int
}
