//
//  CreditsController.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 25/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class CreditsController: UIViewController {

    let credits = Credits()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func loadView() {
        view = self.credits
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
