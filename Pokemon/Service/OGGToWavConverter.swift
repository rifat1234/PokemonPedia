//
//  OggToWavDecoder.swift
//  Pokemon
//
//  Created by Rifat on 02/07/2024.
//

import Foundation
import OggDecoder

struct OGGToWavConverter {
    private let decoder = OGGDecoder()
    
    func convertToWav(_ url: URL)->URL? {
        decoder.decode(url)
    }
}
