//
//  AudioPlayer.swift
//  Pokemon
//
//  Created by Rifat on 02/07/2024.
//

import Foundation
import AVFAudio

class AudioPlayer {
    private var player: AVAudioPlayer?
    
    func play(url: URL) throws {
        player = try AVAudioPlayer(contentsOf: url)
        player?.play()
    }
}
