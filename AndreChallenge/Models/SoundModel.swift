//
//  SoundModel.swift
//  AndreChallenge
//
//  Created by Shanezzar Sharon on 24/11/2021.
//

import AVKit

struct SoundModel {
    
    // MARK:- variables
    static var shared = SoundModel()
    
    var audioPlayer: AVAudioPlayer! = nil

    mutating func playRefresh() {
        let path = Bundle.main.path(forResource: "refresh", ofType: "wav")
        let url = URL(fileURLWithPath: path!)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("error")
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
}
