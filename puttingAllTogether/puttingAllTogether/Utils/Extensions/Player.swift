//
//  Player.swift
//  puttingAllTogether
//
//  Created by Lucas Fernandes on 15/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import Foundation
import AVFoundation

public class Player: AVAudioPlayer {
    public var identifier: PlayerType?
    //public var path: URL?
    
    init(identifier: PlayerType, url: URL) throws {
        self.identifier = identifier
        try super.init(contentsOf: url)
       
    }
    
    override init() {
        super.init()
    }
}
