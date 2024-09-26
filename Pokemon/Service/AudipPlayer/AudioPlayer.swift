//
//  AudioPlayer.swift
//  Pokemon
//
//  Created by Rifat on 02/07/2024.
//

import Foundation
import AVFAudio

class AudioPlayer: AudioPlayerDef {
    private var player: AVAudioPlayer?
    
    func play(url: URL) throws {
        try AVAudioSession.sharedInstance().setCategory(.playback)
        try AVAudioSession.sharedInstance().setActive(true)
        player = try AVAudioPlayer(contentsOf: url)
        player?.play()
    }
}
