//
//  ProgressManager.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 08.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import Foundation
import SVProgressHUD

final class ProgressManager {
    static let shared = ProgressManager()
    
    fileprivate init() {}
    
    open func show() {
        SVProgressHUD.show()
    }
    
    open func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    open func error(text: String) {
        SVProgressHUD.showError(withStatus: text)
    }
    
}
