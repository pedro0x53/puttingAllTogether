//
//  Gameplay.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 03/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class Gameplay: UIView {
    
    let pauseBtn: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .smokyBlack
    }
}
