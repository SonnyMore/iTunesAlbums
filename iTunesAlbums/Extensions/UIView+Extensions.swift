//
//  UIView+Extensions.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit

extension UIView {
    
    static func instance() -> Self {
        return view(viewClass: self)
    }
    
    static func view<T: UIView>(viewClass: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as! T
    }
    
}
