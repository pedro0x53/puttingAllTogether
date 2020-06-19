//
//  ChapterSceneManager.swift
//  puttingAllTogether
//
//  Created by Hiago Chagas on 18/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import Foundation


class ChapterSceneManager{
    public var currentChapter: Chapter? 
    public var currentScene: Scene?
    public static let shared: ChapterSceneManager = ChapterSceneManager()
    
    
    
    init() {
        //let save = StoreManager.getLastSave()
        currentChapter = getChapter(id: 0)!
        currentScene = currentChapter?.scenes[0]
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    //unused till now
    func parseJSON(jsonData: Data){
        do {
            self.currentChapter = try JSONDecoder().decode(Chapter.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    private func getChapter(id: Int) -> Chapter? {
        var res: Chapter?
        //data is feeding from only one json
        if let data = readLocalFile(forName: "data") {
            do {
                let chapter = try JSONDecoder().decode(Chapter.self, from: data)
                    if chapter.chapterID == id {
                        res = chapter
                    }
                
            } catch {
                print("""
                    Unable to decode chapter.
                    \(error.localizedDescription)
                """)
            }
        }
        
        return res
    }

    public func getNextScene() {
        guard let chapter = currentChapter else { fatalError("Could not read currentChapter") }
        guard let scene = currentScene else { fatalError("Could not read currentScene") }
        if scene.sceneID < chapter.scenes.count + 1 {
            currentScene = chapter.scenes[scene.sceneID + 1]
        } else {
            currentChapter = getChapter(id: chapter.chapterID + 1)!
            currentScene = chapter.scenes[0]
        }
    }
   //unused
//    func getInfo(){
//        print("Chapter ID: \(String(describing: chapter?.chapterID))")
//        var aux = 0
//        guard let scenes = chapter?.scenes else { return }
//        for scene in scenes{
//            print("Scene \(aux)")
//            print("Audio URL: \(scene.audioURL)")
//            if scene.hasGestures{
//                print(scene.gestures!)
//            }
//            if scene.hasSFX{
//                print(scene.sfx!)
//            }
//            aux+=1
//        }
//    }
}
