//
//  GesturesManager.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 15/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

public enum GesturesType {
    case up
    case right
    case down
    case left
}

class GesturesManager {
    
    public static let shared: GesturesManager = GesturesManager()
    public var delegate: ManagerDelegate? {
        didSet {
            setupGestures()
        }
    }
    
    private let swipeUpGesture    = UISwipeGestureRecognizer()
    private let swipeRightGesture = UISwipeGestureRecognizer()
    private let swipeDownGesture  = UISwipeGestureRecognizer()
    private let swipeLeftGesture  = UISwipeGestureRecognizer()
    
    private init() {
        
    }
    
    private func setupGestures() {
        swipeUpGesture.addTarget(self, action: #selector(swipeUp))
        swipeUpGesture.direction = .up
        swipeUpGesture.delegate = delegate
        
        swipeRightGesture.addTarget(self, action: #selector(swipeRight))
        swipeRightGesture.direction = .right
        swipeRightGesture.delegate = delegate
        
        swipeDownGesture.addTarget(self, action: #selector(swipeDown))
        swipeDownGesture.direction = .down
        swipeDownGesture.delegate = delegate
        
        swipeLeftGesture.addTarget(self, action: #selector(swipeLeft))
        swipeLeftGesture.direction = .left
        swipeLeftGesture.delegate = delegate
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
    
    public func activateSwipes(gameplay: Gameplay, gestures: GesturesType...) {
        for gesture in gestures {
            switch gesture {
            case .up:
                gameplay.swipeLayer.addGestureRecognizer(swipeUpGesture)
                gameplay.topView.isHidden = false
                UIView.animate(withDuration: 1.5, animations: {
                    gameplay.topView.alpha = 0.9
                }, completion: { (completion) in
                    gameplay.topView.layer.add(Gameplay.pulseAnimation, forKey: "pulseAnimation")
                })
            case .right:
                gameplay.swipeLayer.addGestureRecognizer(swipeRightGesture)
                gameplay.rightView.isHidden = false
                UIView.animate(withDuration: 1.5, animations: {
                    gameplay.rightView.alpha = 0.9
                }, completion: { (completion) in
                    gameplay.rightView.layer.add(Gameplay.pulseAnimation, forKey: "pulseAnimation")
                })
            case .down:
                gameplay.swipeLayer.addGestureRecognizer(swipeDownGesture)
                gameplay.bottomView.isHidden = false
                UIView.animate(withDuration: 1.5, animations: {
                    gameplay.bottomView.alpha = 0.9
                }, completion: { (completion) in
                    gameplay.bottomView.layer.add(Gameplay.pulseAnimation, forKey: "pulseAnimation")
                })
            case .left:
                gameplay.swipeLayer.addGestureRecognizer(swipeLeftGesture)
                gameplay.leftView.isHidden = false
                UIView.animate(withDuration: 1.5, animations: {
                    gameplay.leftView.alpha = 0.9
                }, completion: { (completion) in
                    gameplay.leftView.layer.add(Gameplay.pulseAnimation, forKey: "pulseAnimation")
                })
            }
        }
    }
    
    public func deactivateSwipes(gameplay: Gameplay, gestures: GesturesType...) {
        for gesture in gestures {
            switch gesture {
            case .up:
                gameplay.swipeLayer.removeGestureRecognizer(swipeUpGesture)
                UIView.animate(withDuration: 1.5, animations: {
                    gameplay.topView.alpha = 0
                }, completion: { (completion) in
                    gameplay.topView.isHidden = true
                })
            case .right:
                gameplay.swipeLayer.removeGestureRecognizer(swipeRightGesture)
                UIView.animate(withDuration: 1.5, animations: {
                    gameplay.rightView.alpha = 0
                }, completion: { (completion) in
                    gameplay.rightView.isHidden = true
                })
            case .down:
                gameplay.swipeLayer.removeGestureRecognizer(swipeDownGesture)
                UIView.animate(withDuration: 1.5, animations: {
                    gameplay.bottomView.alpha = 0
                }, completion: { (completion) in
                    gameplay.bottomView.isHidden = true
                })
            case .left:
                gameplay.swipeLayer.removeGestureRecognizer(swipeLeftGesture)
                UIView.animate(withDuration: 1.5, animations: {
                    gameplay.leftView.alpha = 0
                }, completion: { (completion) in
                    gameplay.leftView.isHidden = true
                })
            }
        }
    }
}
