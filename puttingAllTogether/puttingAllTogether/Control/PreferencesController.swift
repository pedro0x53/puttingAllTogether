//
//  PreferencesController.swift
//  puttingAllTogether
//
//  Created by Hiago Chagas on 11/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class PreferencesController: UIViewController {
    //preferences view
    var preferences = Preferences()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func loadView() {
        super.loadView()
        view = preferences
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Preferências"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
