//
//  ChapterSceneConfig.swift
//  puttingAllTogether
//
//  Created by Hiago Chagas on 16/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import Foundation

let jsonTemplate = """
{
    "chapterID"       : 0,
    "scenes" : [{
        "audioURL"    : "The URL",
        "hasGestures" : true,
        "gestures"    : ["up","down"],
        "hasSFX"      : true,
        "sfx"         : ["screaming", "leaves"]
    }]
}
""".data(using: .utf8)!

class ChapterSceneConfig{
    var chapter: Chapter?
    func decodeJSON(){
        let decoder = JSONDecoder()
        do {
            self.chapter = try decoder.decode(Chapter.self, from: jsonTemplate)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getInfo(){
        print("Chapter ID: \(String(describing: chapter?.chapterID))")
        var aux = 0
        guard let scenes = chapter?.scenes else { return }
        print(scenes)
        for scene in scenes{
            print("Scene \(aux)")
            print("Audio URL: \(scene.audioURL)")
            if scene.hasGestures{
                print(scene.gestures!)
            }
            if scene.hasSFX{
                print(scene.sfx!)
            }
            aux+=1
        }
    }
}


