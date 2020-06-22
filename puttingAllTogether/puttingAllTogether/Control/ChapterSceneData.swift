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
    let scenes: [Scene]
    let lastChapter: Bool
}

struct Scene: Codable {
    let sceneID: Int
    let audioURL: String
    let hasSFX: Bool
    let sfx: [SFX]
    let hasGestures: Bool
    let gestures: [String]
    let nextSceneIncrementer: [Int]
}

struct SFX: Codable{
    let audioURL: String
    let channel: String
}
