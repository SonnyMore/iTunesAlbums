//
//  ViewController.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit

//SearchBar delegate
protocol AlbumsListViewSearchDelegate {
    func didSearchBarButtonPressed(text: String)
    func didSearchBarBeginEditing()
    func didSearchBarEndEditing()
}

//Collection View Selection delegate
protocol AlbumsListViewCollectionDelegate {
    func didAlbumSelected(album: AlbumEntity)
}

class AlbumsListVC: UIViewController {
    
    private var albumsListView: AlbumsListView!
    private lazy var albumsListService = AlbumsListService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
    }
    
    override func loadView() {
        albumsListView = AlbumsListView.instance()
        self.view = albumsListView
    }
    
    private func setupVC() {
        self.title = "Список альбомов"
        self.hideKeyboardWhenTappedAround()
        albumsListView.setDelegate(delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AlbumsListVC: AlbumsListViewSearchDelegate {
    func didSearchBarBeginEditing() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func didSearchBarEndEditing() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func didSearchBarButtonPressed(text: String) {
        if (!text.isEmpty) {
            albumsListService.loadAlbums(by: text, success: { [weak self] in
                self?.albumsListView.updateData(data: self!.albumsListService.getAlbums())
            }) { (error) in
                ProgressManager.shared.error(text: error)
            }
        }
    }
}

extension AlbumsListVC: AlbumsListViewCollectionDelegate {
    func didAlbumSelected(album: AlbumEntity) {
        let vc = AlbumDetailsVC()
        vc.setAlbum(album: album)
        navigationController?.pushViewController(vc, animated: true)
    }
}
