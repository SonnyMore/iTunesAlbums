//
//  MoyaService.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import Moya

enum ITunesAlbumsNetworking {
    case getAlbums(String)
    case getAlbumDetails(Int)
}

//closures for requests
typealias requestSuccess = () -> ()
typealias requestFailed = (String) -> ()

extension ITunesAlbumsNetworking: TargetType {
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    
    var path: String {
        switch self {
        case .getAlbums(_):
            return "/search"
        case .getAlbumDetails(_):
            return "/lookup"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAlbums(let albumTitle):
            return .requestParameters(parameters: ["term":albumTitle, "entity":"album"], encoding: URLEncoding.default)
        case .getAlbumDetails(let albumId):
            return .requestParameters(parameters: ["id":albumId, "entity":"song"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
