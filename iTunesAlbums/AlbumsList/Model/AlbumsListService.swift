//
//  AlbumsListService.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import Foundation
import Moya

//Сервис загрузки альбомов по названию
class AlbumsListService {
    private var albums = [AlbumEntity]()
    
    private let itunesAlbumsProvider = MoyaProvider<ITunesAlbumsNetworking>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func loadAlbums(by title:String, success: @escaping requestSuccess, failed: @escaping requestFailed) {
        ProgressManager.shared.show()
        itunesAlbumsProvider.request(.getAlbums(title)) { [weak self] (result) in
            ProgressManager.shared.dismiss()
            //Сериализиуем ответ, mapResponse реализована в Moya.response extension
            if let response = try? result.dematerialize(),
               let data: ITunesBasicResponse<AlbumEntity> = response.mapResponse()  {
                //Сортируем альбомы по алфавиту
                self?.albums = data.results.sorted{$0.collectionName < $1.collectionName}
                success()
            } else {
                if let error = result.error?.localizedDescription {
                    failed(error)
                } else {
                    failed("Неизвестная ошибка!")
                }
            }
        }
    }
    
    func getAlbums() -> [AlbumEntity] {
        return albums
    }
}
