//
//  AlbumDetailsView.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 08.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit

class AlbumDetailsView: UIView {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumArtistView: AlbumDetailsArtistView!
    @IBOutlet weak var albumSongsTable: AlbumDetailsSongsTableView!
    
    private var songs = [AlbumSong]()
    private weak var playingDelegate: AlbumDetailsPlayingSongDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTable()
    }
    
    private func setupTable() {
        albumSongsTable.delegate = self
        albumSongsTable.dataSource = self
    }
    
    func setupView(with album: AlbumEntity, playingSongDelegate: AlbumDetailsPlayingSongDelegate) {
        self.playingDelegate = playingSongDelegate
        albumArtistView.setupView(with: album)
        guard let albumImageUrl = URL(string: album.artworkUrl100) else {
            albumImage.image = #imageLiteral(resourceName: "albumPlaceholder")
            return
        }
        albumImage.kf.setImage(with: albumImageUrl, placeholder: #imageLiteral(resourceName: "albumPlaceholder"), options: [.transition(.fade(0.6))], progressBlock: nil, completionHandler: nil)
    }
    
    func showSongs(songs: [AlbumSong]) {
        self.songs = songs
        DispatchQueue.main.async { [weak self] in
            self?.albumSongsTable.reloadData()
        }
    }
}

extension AlbumDetailsView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumDetailsSongCell", for: indexPath) as! AlbumDetailsSongCell
        cell.setupCell(with: songs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = songs[indexPath.row]
        self.playingDelegate?.playSong(song: song)
    }
}
