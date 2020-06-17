//
//  MenuManager.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 17/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

public enum MenuType {
    case initial
    case gameplay
}

public class MenuManager {
    public static func getMenu(type: MenuType) -> [MenuItem] {
        switch type {
        case .initial:
            return [MenuItem(icon: "play_icon", label: "Start",
                             action: .start),
                    MenuItem(icon: "settings_icon", label: "Preferências",
                             action: .preferences),
                MenuItem(icon: "exit_icon", label: "Sair",
                         action: .exit)]
        case .gameplay:
            return [MenuItem(icon: "play_icon", label: "Resume",
                             action: .resume),
                    MenuItem(icon: "settings_icon", label: "Preferências",
                             action: .preferences),
                    MenuItem(icon: "exit_icon", label: "Sair",
                             action: .exit)]
        }
    }
}
