//
//  AlbumDetailsSongCell.swift
//  iTunesAlbums
//
//  Created by Сеин Михаил on 08.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import UIKit

class AlbumDetailsSongCell: UITableViewCell {
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songTime: UILabel!
    @IBOutlet weak var playStatusImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(with song: AlbumSong) {
        songTitle.text = song.trackName!
        let minutes = Int(song.trackTimeMillis!/(1000*60))
        let seconds = Int((song.trackTimeMillis!/1000).truncatingRemainder(dividingBy: 60))
        if (seconds < 10) {
            songTime.text = "\(minutes):0\(seconds)"
        } else {
            songTime.text = "\(minutes):\(seconds)"
        }
        playStatusImageView.image = song.isPlaying ? #imageLiteral(resourceName: "AudioPause") : #imageLiteral(resourceName: "AudioPlay")
    }
}
