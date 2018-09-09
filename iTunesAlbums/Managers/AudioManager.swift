//
//  AudioManager.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 08.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import AVFoundation

final class AudioManager {
    static let shared = AudioManager()
    
    fileprivate init() {}
    
    private var audioPlayer: AVAudioPlayer!
    
    //инициализируем плеер по url
    func setUrl(url: String, delegate: AVAudioPlayerDelegate, success: @escaping requestSuccess, failed: @escaping requestFailed) {
        //если песня уже играет - останавливаем
        if (audioPlayer != nil), audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        if let url = URL(string: url) {
            ProgressManager.shared.show()
            DispatchQueue.global(qos: .background).async { [weak self] in
                do {
                    let data = try Data(contentsOf: url)
                    let player = try AVAudioPlayer(data: data)
                    self?.audioPlayer = player
                    self?.registerDelegate(delegate: delegate)
                    ProgressManager.shared.dismiss()
                    success()
                } catch let playerError {
                    ProgressManager.shared.dismiss()
                    failed(playerError.localizedDescription)
                }
            }
        }
    }
    
    func play() {
        audioPlayer.play()
    }
    
    func stop() {
        audioPlayer.stop()
    }
    
    private func registerDelegate(delegate: AVAudioPlayerDelegate) {
        audioPlayer.delegate = delegate
    }
    
    func unregisterDelegate() {
        if (audioPlayer != nil) {
            audioPlayer.delegate = nil
        }
    }
    
}
