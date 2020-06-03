//
//  GameplayController.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 02/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

public enum SwipeDirection {
    case up
    case right
    case down
    case left
}

class GameplayController: UIViewController, UIGestureRecognizerDelegate {
    
    var gameplay = Gameplay()
    
    private let pinchGesture      = UIPinchGestureRecognizer()
    private let swipeUpGesture    = UISwipeGestureRecognizer()
    private let swipeRightGesture = UISwipeGestureRecognizer()
    private let swipeDownGesture  = UISwipeGestureRecognizer()
    private let swipeLeftGesture  = UISwipeGestureRecognizer()
    
    override func loadView() {
        view = gameplay
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        self.activateSwipes(swipes: .up, .right, .down, .left)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        play()
    }
    
    private func setupGestures() {
        pinchGesture.addTarget(self, action: #selector(pinch))
        pinchGesture.delegate = self
        gameplay.addGestureRecognizer(pinchGesture)
        
        swipeUpGesture.addTarget(self, action: #selector(swipeUp))
        swipeUpGesture.direction = .up
        swipeUpGesture.delegate = self
        
        swipeRightGesture.addTarget(self, action: #selector(swipeRight))
        swipeRightGesture.direction = .right
        swipeRightGesture.delegate = self
        
        swipeDownGesture.addTarget(self, action: #selector(swipeDown))
        swipeDownGesture.direction = .down
        swipeDownGesture.delegate = self
        
        swipeLeftGesture.addTarget(self, action: #selector(swipeLeft))
        swipeLeftGesture.direction = .left
        swipeLeftGesture.delegate = self
    }
    
    @objc private func pinch(_ pinch: UIPinchGestureRecognizer) {
        if(pinch.scale > 1) {
            print("Pinch out gesture rocognized!")
        } else {
            print("Pinch in gesture rocognized!")
        }
    }
    
    @objc private func swipeUp() {
        print("Swipe up recognized!")
    }
    
    @objc private func swipeRight() {
        print("Swipe right recognized!")
    }
    
    @objc private func swipeDown() {
        print("Swipe down recognized!")
    }
    
    @objc private func swipeLeft() {
        print("Swipe left recognized!")
    }
    
    private func activateSwipes(swipes: SwipeDirection...) {
        for swipe in swipes {
            switch swipe {
            case .up:
                gameplay.addGestureRecognizer(swipeUpGesture)
            case .right:
                gameplay.addGestureRecognizer(swipeRightGesture)
            case .down:
                gameplay.addGestureRecognizer(swipeDownGesture)
            case .left:
                gameplay.addGestureRecognizer(swipeLeftGesture)
            }
        }
    }
    
    private func deactivateSwipes(swipes: SwipeDirection...) {
        for swipe in swipes {
            switch swipe {
            case .up:
                gameplay.removeGestureRecognizer(swipeUpGesture)
            case .right:
                gameplay.removeGestureRecognizer(swipeRightGesture)
            case .down:
                gameplay.removeGestureRecognizer(swipeDownGesture)
            case .left:
                gameplay.removeGestureRecognizer(swipeLeftGesture)
            }
        }
    }
}

extension GameplayController {
    private func play() {
        print("Gameplay logic goes here...")
    }
}
