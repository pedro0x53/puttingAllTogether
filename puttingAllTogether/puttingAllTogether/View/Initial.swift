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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        menu.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
