//
//  ChapterSceneManager.swift
//  puttingAllTogether
//
//  Created by Hiago Chagas on 18/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import Foundation

class ChapterSceneManager{
    
    public static let shared: ChapterSceneManager = ChapterSceneManager()
    
    private var chapter: Chapter? {
        didSet {
            if let chapter = self.chapter {
                currentChapter = chapter
            }
        }
    }
    public var currentChapter: Chapter!
    
    private var scene: Scene? {
        didSet {
            if let scene = self.scene {
                currentScene = scene
            }
        }
    }
    public var currentScene: Scene!
    
    init() {
        //let save = StoreManager.getLastSave()
        currentChapter = getChapter(id: 0)
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
            fatalError("""
                Failed to decode JSON
                \(error.localizedDescription)
            """)
        }
    }
    
    
    
    private func getChapter(id: Int) -> Chapter? {
        var res: Chapter?
        //data is feeding from only one json
        if let data = readLocalFile(forName: "chapter\(id)") {
            do {
                let chapter = try JSONDecoder().decode(Chapter.self, from: data)
                    if chapter.chapterID == id {
                        res = chapter
                    }
                
            } catch {
                fatalError("""
                    Unable to decode chapter.
                    \(error.localizedDescription)
                """)
            }
        }
        
        return res
    }

    public func getNextScene() {
        if self.currentScene.sceneID < currentChapter.scenes.count - 1 {
            self.currentScene = self.currentChapter.scenes[currentScene.sceneID + 1]
        } else {
            self.chapter = getChapter(id: currentChapter.chapterID + 1)!
            self.currentScene = self.currentChapter.scenes[0]
        }
    }
}
