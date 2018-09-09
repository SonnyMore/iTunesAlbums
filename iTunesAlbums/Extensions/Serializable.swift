//
//  Serializable.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import Foundation

//Протокол для сериализации объектов
protocol Serializable : Codable {
    static func deserialize<T: Serializable>(data: Any) -> T?
}

extension Serializable {
    static func deserialize<T: Serializable>(data: Any) -> T? {
        guard let data = data as? Data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted),
            let decodedObject = try? JSONDecoder().decode(T.self, from: jsonData) else {
                return nil
        }
        return decodedObject
    }
}
