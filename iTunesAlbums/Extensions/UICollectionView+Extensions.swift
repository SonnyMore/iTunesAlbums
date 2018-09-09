//
//  UICollectionView+Extensions.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 08.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit

//Отображаем картинку когда результат поиска пустой
extension UICollectionView {
    func emptyResultBackgroundView() -> UIView {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "albumNoResult"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
