//
//  InitialController.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 02/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class InitialController: UIViewController {
    
    var initial = Initial()
    
    override func loadView() {
        view = initial
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupActions() {
        self.initial.startBtn.addTarget(
            self,
            action: #selector(start),
            for: .touchUpInside)
    }
    
    @objc private func start() {
        let gameplayController = GameplayController()
        self.navigationController?.pushViewController(gameplayController, animated: true)
    }
    
}
