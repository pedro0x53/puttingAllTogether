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
    
    var gameplay = Gameplay.shared
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        deactivateSwipes(swipes: .up, .right, .down, .left)
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
            print("Code to show the menu goes here...")
        } else {
            print("(Maybe) Code to hide the menu goes here...")
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
                gameplay.topView.isHidden = false
                UIView.animate(withDuration: 1.5, animations: {
                    self.gameplay.topView.alpha = 0.9
                }, completion: { (completion) in
                    self.gameplay.topView.layer.add(Gameplay.pulseAnimation, forKey: "pulseAnimation")
                })
            case .right:
                gameplay.addGestureRecognizer(swipeRightGesture)
                gameplay.rightView.isHidden = false
                UIView.animate(withDuration: 1.5, animations: {
                    self.gameplay.rightView.alpha = 0.9
                }, completion: { (completion) in
                    self.gameplay.rightView.layer.add(Gameplay.pulseAnimation, forKey: "pulseAnimation")
                })
            case .down:
                gameplay.addGestureRecognizer(swipeDownGesture)
                gameplay.bottomView.isHidden = false
                UIView.animate(withDuration: 1.5, animations: {
                    self.gameplay.bottomView.alpha = 0.9
                }, completion: { (completion) in
                    self.gameplay.bottomView.layer.add(Gameplay.pulseAnimation, forKey: "pulseAnimation")
                })
            case .left:
                gameplay.addGestureRecognizer(swipeLeftGesture)
                gameplay.leftView.isHidden = false
                UIView.animate(withDuration: 1.5, animations: {
                    self.gameplay.leftView.alpha = 0.9
                }, completion: { (completion) in
                    self.gameplay.leftView.layer.add(Gameplay.pulseAnimation, forKey: "pulseAnimation")
                })
            }
        }
    }
    
    private func deactivateSwipes(swipes: SwipeDirection...) {
        for swipe in swipes {
            switch swipe {
            case .up:
                gameplay.removeGestureRecognizer(swipeUpGesture)
                UIView.animate(withDuration: 1.5, animations: {
                    self.gameplay.topView.alpha = 0
                }, completion: { (completion) in
                    self.gameplay.topView.isHidden = true
                })
            case .right:
                gameplay.removeGestureRecognizer(swipeRightGesture)
                UIView.animate(withDuration: 1.5, animations: {
                    self.gameplay.rightView.alpha = 0
                }, completion: { (completion) in
                    self.gameplay.rightView.isHidden = true
                })
            case .down:
                gameplay.removeGestureRecognizer(swipeDownGesture)
                UIView.animate(withDuration: 1.5, animations: {
                    self.gameplay.bottomView.alpha = 0
                }, completion: { (completion) in
                    self.gameplay.bottomView.isHidden = true
                })
            case .left:
                gameplay.removeGestureRecognizer(swipeLeftGesture)
                UIView.animate(withDuration: 1.5, animations: {
                    self.gameplay.leftView.alpha = 0
                }, completion: { (completion) in
                    self.gameplay.leftView.isHidden = true
                })
            }
        }
    }
}

extension GameplayController {
    private func play() {
        print("Gameplay logic goes here...")
//        self.activateSwipes(swipes: .up, .right, .down, .left)
    }
}
