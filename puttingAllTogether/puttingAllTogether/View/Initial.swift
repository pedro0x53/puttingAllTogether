//
//  Initial.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 03/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class Initial: UIView {
    
    let bkg: UIImageView = UIImageView(image: UIImage(named: "bkg"))
    let menu: Menu = Menu()
    let menuTitle: UILabel = {
        let lbl = UILabel()
            lbl.text = "Abulia"
            lbl.font = UIFont.systemFont(ofSize: 100)
            lbl.layer.shadowColor = UIColor.usafaBlue.cgColor
            lbl.layer.shadowRadius = 5.0
            lbl.layer.shadowOpacity = 5.0
            lbl.layer.shadowOffset = CGSize(width: 4, height: 4)
            lbl.layer.masksToBounds = false
            lbl.textColor = .dodgerBlue
        return lbl
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static let labelAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
            animation.values = [0.9, 0.3, 0.9]
            animation.keyTimes = [0, 0.5, 1]
            animation.repeatCount = Float.infinity
            animation.duration = 4
        return animation
    }()
    
    private func setupLayout() {
        self.addSubview(bkg)
        bkg.contentMode = UIView.ContentMode.center
        bkg.frame.size.width = UIScreen.main.bounds.width
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = bkg.bounds
        self.addSubview(blurredEffectView)
        
        self.addSubview(menu)
        menu.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        menu.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        menu.heightAnchor.constraint(equalToConstant: 350).isActive = true
        menu.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 40).isActive = true
        
        self.addSubview(menuTitle)
        menuTitle.translatesAutoresizingMaskIntoConstraints = false
        menuTitle.bottomAnchor.constraint(equalTo: menu.topAnchor, constant: -10).isActive = true
        menuTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        menuTitle.layer.add(Initial.labelAnimation, forKey: "labelAnimation")
    }
}
