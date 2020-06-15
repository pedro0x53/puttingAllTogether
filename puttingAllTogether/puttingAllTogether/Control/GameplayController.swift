//
//  GameplayController.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 02/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class GameplayController: UIViewController {
    
    private let gameplay: Gameplay = Gameplay.shared
    private let gestureManager: GesturesManager = GesturesManager.shared
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func loadView() {
        super.loadView()
        view = gameplay
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureManager.delegate = self
        gestureManager.activateSwipes(gameplay: gameplay, gestures: .pinch)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tell()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

extension GameplayController: ManagerDelegate {
    private func tell() {
        print("Gameplay logic goes here...")
        gestureManager.activateSwipes(gameplay: gameplay, gestures: .up, .right, .down, .left)
    }
    
    func playerDidFinished() {
        print("Audio Finished")
    }
    
    func gestureRecognized() {
        print("Gesture Recognized")
    }
}
