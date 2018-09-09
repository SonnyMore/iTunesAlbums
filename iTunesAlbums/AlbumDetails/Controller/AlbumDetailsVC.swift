//
//  AlbumDetailsVC.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 08.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit
import AVFoundation

protocol AlbumDetailsPlayingSongDelegate: class {
    func playSong(song: AlbumSong)
}

class AlbumDetailsVC: UIViewController {
    private weak var albumDetailsView: AlbumDetailsView!
    private var albumDetailsService = AlbumDetailsService()
    private var album: AlbumEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupView()
        loadSongs()
    }

    //Обязательно отписываемся от делегата аудио-плеера
    deinit {
        print("deinit")
        albumDetailsService.shouldUnregisterDelegate()
    }
    
    override func loadView() {
        albumDetailsView = AlbumDetailsView.instance()
        self.view = albumDetailsView
    }
    
    private func setupVC() {
        self.title = "Описание альбома"
        //hero.isEnabled = true
    }
    
    private func setupView() {
        albumDetailsView.setupView(with: album, playingSongDelegate: self)
    }
    
    func setAlbum(album: AlbumEntity) {
        self.album = album
    }
    
    private func loadSongs() {
        albumDetailsService.loadSongs(by: album.collectionId, success: { [weak self] in
            self?.albumDetailsView.showSongs(songs: self!.albumDetailsService.getSongs())
         }) { (error) in
            ProgressManager.shared.error(text: error)
         }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AlbumDetailsVC: AlbumDetailsPlayingSongDelegate {
    func playSong(song: AlbumSong) {
        albumDetailsService.playSong(song: song, playingDelegate: self, success: { [weak self] in
            self?.albumDetailsView.showSongs(songs: self!.albumDetailsService.getSongs())
        }) { (error) in
            ProgressManager.shared.error(text: "Ошибка воспроизведения: \(error)")
        }
    }
}

extension AlbumDetailsVC: AVAudioPlayerDelegate {
    //Обновляем таблицу(статус проигрывания) после того как песня закончилась
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.albumDetailsService.didPlayingFinished()
        self.albumDetailsView.showSongs(songs: self.albumDetailsService.getSongs())
    }
}
