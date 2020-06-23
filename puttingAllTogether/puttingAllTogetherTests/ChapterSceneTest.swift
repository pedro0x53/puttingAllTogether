//
//  ChapterSceneTest.swift
//  puttingAllTogetherTests
//
//  Created by Pedro Henrique Costa on 23/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import XCTest
@testable import puttingAllTogether

class ChapterSceneTest : XCTestCase {
    
    func test_chapterManager_updateScene_manyScenes() {
        
        //Given
        let testSfx = puttingAllTogether.SFX(audioURL: "test", channel: "left")
        let testScene1 = puttingAllTogether.Scene(sceneID: 0, audioURL: "test", hasSFX: true, sfx: [testSfx], hasGestures: false, gestures: [], nextSceneIncrementer: [])
        let testScene2 = puttingAllTogether.Scene(sceneID: 1, audioURL: "test", hasSFX: true, sfx: [testSfx], hasGestures: false, gestures: [], nextSceneIncrementer: [])
        let testChapter = puttingAllTogether.Chapter(chapterID: 0, scenes: [testScene1, testScene2], lastChapter: true)
        ChapterSceneManager.shared.currentChapter = testChapter
        ChapterSceneManager.shared.currentScene = testScene1
        
        //When
        ChapterSceneManager.shared.updateScene()
        
        //Then
        XCTAssertEqual(ChapterSceneManager.shared.currentScene.sceneID, 1)
    }
    
}
