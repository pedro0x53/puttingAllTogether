//
//  Config.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 02/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class Config {
    
    func mainController() -> UIViewController {
        let nav = setupNavController()
        let controller = InitialController()
        
        nav.viewControllers = [controller]
        
        return nav
    }
    
    private func setupNavController() -> UINavigationController {
        let nav = UINavigationController()
        nav.navigationBar.barTintColor = .smokyBlack
        nav.navigationBar.tintColor = .cultured
        nav.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 21, weight: .bold)]
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = nav.navigationBar.bounds
        nav.navigationBar.addSubview(blurredEffectView)
        
        return nav
    }
}
