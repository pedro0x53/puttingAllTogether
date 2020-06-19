//
//  ChapterSceneData.swift
//  puttingAllTogether
//
//  Created by Hiago Chagas on 15/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//
import Foundation
struct Chapter: Codable{
    let chapterID: Int
    var scenes: [Scene]
}
struct Scene: Codable {
    let sceneID: Int
    let audioURL: String
    let hasGestures: Bool
    let gestures: [String]
    let hasSFX: Bool
    let sfx: [SFX]
}

struct SFX: Codable{
    let audioURL: String
    let options: sfxOptions
}
struct sfxOptions: Codable{
    let channel: String
    let volume: Double
}



