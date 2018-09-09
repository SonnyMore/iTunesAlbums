//
//  Moya+Response.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import Moya

extension Moya.Response {
    func mapResponse<T: Serializable>() -> T? {
        guard let any: T = T.deserialize(data: self.data) else {
            return nil
        }
       
        return any
    }
}
