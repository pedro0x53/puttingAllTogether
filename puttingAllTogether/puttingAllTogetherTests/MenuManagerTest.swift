//
//  MenuManagerTest.swift
//  puttingAllTogetherTests
//
//  Created by Pedro Henrique Costa on 24/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import XCTest
@testable import puttingAllTogether

enum MenuType {
    case initial
    case gameplay
}

class MenuManagerTest : XCTestCase {

    func test_menuManager_getMenu_initial() {
        
        //Given
        
        //When
        let menu = MenuManager.getMenu(type: .initial)
        
        //Then
        XCTAssertEqual(menu[0].action, puttingAllTogether.Actions.start)
        
    }
    
    func test_menuManager_getMenu_gameplay() {
        
        //Given
        
        //When
        let menu = MenuManager.getMenu(type: .gameplay)
        
        //Then
        XCTAssertEqual(menu[0].action, puttingAllTogether.Actions.resume)
        
    }
    
}
