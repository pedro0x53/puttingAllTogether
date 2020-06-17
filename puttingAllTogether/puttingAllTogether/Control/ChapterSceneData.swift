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
    func nextChapter(){
        //pass onto the next chapter
    }
}
struct Scene: Codable {
    let audioURL: String
    let hasGestures: Bool
    let gestures: [String]?
    let hasSFX: Bool
    let sfx: [String]?
    
    func nextScene(){
        //goes to the next scene
    }
}



