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
    
//    private let storage: StorageManager = StorageManager.shared
    private let ud = UserDefaults.standard

    public var currentChapter: Chapter! {
        didSet {
            ud.set(currentChapter.chapterID, forKey: "chapterId")
        }
    }
    public var currentScene: Scene! {
        didSet {
            ud.set(currentScene.sceneID, forKey: "sceneId")
        }
    }
    
    init() {
        if ud.object(forKey: "chapterId") != nil {
            let chapterId = ud.integer(forKey: "chapterId")
            let sceneId = ud.integer(forKey: "sceneId")
            
            currentChapter = getChapter(id: chapterId)
            
            if sceneId > currentChapter.scenes.count - 1 {
                currentScene = currentChapter.scenes[0]
            } else {
                currentScene = currentChapter.scenes[sceneId]
            }
        } else {
            print("First Log")
            currentChapter = getChapter(id: 0)
            currentScene = currentChapter.scenes[0]
        }
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

    public func updateScene(plus: Int = 1) {
        if (self.currentScene.sceneID + plus) <= (currentChapter.scenes.count - 1) {
            self.currentScene = self.currentChapter.scenes[currentScene.sceneID + plus]
        } else {
            if let chapter = getChapter(id: currentChapter.chapterID + 1) {
                self.currentChapter = chapter
                self.currentScene = self.currentChapter.scenes[currentScene.sceneID - plus - 1]
            }
        }
    }
}
