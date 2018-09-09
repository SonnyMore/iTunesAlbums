//
//  ITunesBasicResponse.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import Foundation

//Шаблон ответа от сервера
struct ITunesBasicResponse<T: Serializable>: Serializable {
    var resultCount: Int
    var results: [T]
}
