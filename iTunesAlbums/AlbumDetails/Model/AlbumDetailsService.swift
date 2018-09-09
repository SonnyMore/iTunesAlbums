//
//  AlbumDetailService.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 08.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import AVFoundation
import Moya

class AlbumDetailsService {
    private var songs = [AlbumSong]()
    //id играющего трека
    private var playindSongId = -1
    
    private let itunesAlbumsProvider = MoyaProvider<ITunesAlbumsNetworking>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func loadSongs(by albumId:Int, success: @escaping requestSuccess, failed: @escaping requestFailed) {
        ProgressManager.shared.show()
        itunesAlbumsProvider.request(.getAlbumDetails(albumId)) { [weak self] (result) in
            ProgressManager.shared.dismiss()
            if let response = try? result.dematerialize(),
                let data: ITunesBasicResponse<AlbumSong> = response.mapResponse()  {
                //itunes возвращает первым json-элементом сам альбом
                //он у нас уже есть, нам нужны только песни
                self?.songs = data.results.filter{$0.wrapperType == "track"}
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
    
    func getSongs() -> [AlbumSong] {
        return songs
    }
    
    func playSong(song: AlbumSong, playingDelegate: AVAudioPlayerDelegate, success: @escaping requestSuccess, failed: @escaping requestFailed) {
        //если выбрана песня, которая уже играет - останавливаем плеер
        if (song.trackId! == playindSongId) {
            for iter in 0..<songs.count {
                songs[iter].isPlaying = false
            }
            playindSongId = -1
            AudioManager.shared.stop()
            success()
        } else {
            AudioManager.shared.setUrl(url: song.previewUrl!, delegate: playingDelegate, success: { [weak self] in
                AudioManager.shared.play()
                self?.playindSongId = song.trackId!
                for iter in 0..<self!.songs.count {
                    self!.songs[iter].isPlaying = self!.songs[iter].trackId == song.trackId
                }
                success()
            }) { (error) in
                failed(error)
            }
        }
    }
    
    func didPlayingFinished() {
        for iter in 0..<self.songs.count {
            self.songs[iter].isPlaying = false
        }
    }
    
    func shouldUnregisterDelegate() {
        AudioManager.shared.unregisterDelegate()
    }
}
