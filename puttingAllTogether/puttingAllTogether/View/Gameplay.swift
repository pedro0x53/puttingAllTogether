//
//  Gameplay.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 03/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

private enum GratientDirection {
    case toTop
    case toRight
    case toBottom
    case toLeft
}

class Gameplay: UIView {
    
    public static let shared = Gameplay()
    
    let pauseBtn: UIButton = UIButton()
    
    var topView: UIView = UIView()
    var rightView: UIView = UIView()
    var bottomView: UIView = UIView()
    var leftView: UIView = UIView()
    
    public static let pulseAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
            animation.values = [0.9, 0.3, 0.9]
            animation.keyTimes = [0, 0.5, 1]
            animation.repeatCount = Float.infinity
        animation.duration = 1.8
        return animation
    }()
    
    private init() {
        super.init(frame: UIScreen.main.bounds)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .smokyBlack
        
        let smootherTop = CAGradientLayer()
            smootherTop.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
            smootherTop.locations = [0, 0.5, 1]
            smootherTop.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
            smootherTop.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        
        self.addSubview(topView)
        topView.isHidden = true
        topView.alpha = 0
        topView.backgroundColor = .clear
        topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        topView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        topView.layer.mask = smootherTop
        topView.layer.addSublayer(generateLinearGradient(frame: topView.frame,
                                                         direction: .toBottom))
        
        let smootherRight = CAGradientLayer()
        smootherRight.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        smootherRight.locations = [0, 0.5, 1]
        smootherRight.frame = CGRect(x: 0, y: 0, width: 150, height: UIScreen.main.bounds.height)
        
        self.addSubview(rightView)
        rightView.isHidden = true
        rightView.alpha = 0
        rightView.backgroundColor = .clear
        rightView.frame = CGRect(x: 0, y: 0, width: 150, height: UIScreen.main.bounds.height)
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        rightView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rightView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        rightView.layer.mask = smootherRight
        rightView.layer.addSublayer(generateLinearGradient(frame: rightView.frame,
                                                           direction: .toLeft))
        
        
        let smootherBottom = CAGradientLayer()
        smootherBottom.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        smootherBottom.locations = [0, 0.5, 1]
        smootherBottom.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        smootherBottom.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        
        self.addSubview(bottomView)
        bottomView.isHidden = true
        bottomView.alpha = 0
        bottomView.backgroundColor = .clear
        bottomView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bottomView.layer.mask = smootherBottom
        bottomView.layer.addSublayer(generateLinearGradient(frame: bottomView.frame,
                                                            direction: .toTop))
        
        let smootherLeft = CAGradientLayer()
        smootherLeft.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        smootherLeft.locations = [0, 0.5, 1]
        smootherLeft.frame = CGRect(x: 0, y: 0, width: 150, height: UIScreen.main.bounds.height)
        
        self.addSubview(leftView)
        leftView.isHidden = true
        leftView.alpha = 0
        leftView.backgroundColor = .clear
        leftView.frame = CGRect(x: 0, y: 0, width: 150, height: UIScreen.main.bounds.height)
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        leftView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        leftView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        leftView.layer.mask = smootherLeft
        leftView.layer.addSublayer(generateLinearGradient(frame: leftView.frame,
                                                          direction: .toRight))
        
        
        self.addSubview(pauseBtn)
        pauseBtn.setImage(UIImage(named: "pause_icon"), for: .normal)
        pauseBtn.translatesAutoresizingMaskIntoConstraints = false
        pauseBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pauseBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pauseBtn.topAnchor.constraint(
        equalTo: self.topAnchor, constant: 16).isActive = true
        pauseBtn.rightAnchor.constraint(
            equalTo: self.rightAnchor, constant: -16).isActive = true
        pauseBtn.alpha = 0.5
        pauseBtn.addTarget(self, action: #selector(callMenu), for: .touchUpInside)
    }
    
    private func generateLinearGradient(frame: CGRect, direction: GratientDirection) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.usafaBlue.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 1]
        
        switch direction {
        case .toTop:
            gradient.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1)
        case .toRight:
            gradient.transform = CATransform3DMakeRotation(3 * CGFloat.pi / 2, 0, 0, 1)
        case .toBottom:
            gradient.transform = CATransform3DMakeRotation(0, 0, 0, 1)
        case .toLeft:
            gradient.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        }
        
        gradient.frame = frame
        
        return gradient
    }
    
    @objc func callMenu() {
        print("Code to show menu goes here...")
    }
}
