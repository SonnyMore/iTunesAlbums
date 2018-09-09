//
//  AlbumSong.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 08.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import Foundation

struct AlbumSong: Serializable {
    var kind: String?
    var previewUrl: String?
    var trackId: Int?
    var trackName: String?
    var trackTimeMillis: Double?
    var wrapperType: String
    var isPlaying = false
    
    enum CodingKeys: CodingKey {
        case kind
        case previewUrl
        case trackId
        case trackName
        case trackTimeMillis
        case wrapperType
    }
}
