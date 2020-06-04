//
//  Initial.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 03/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class Initial: UIView {
    
    var startBtn: UIButton = UIButton()
    
    var weatherInfo = WeatherAPI()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        weatherInfo.weatherRequestInfo()
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        weatherInfo.printAllInfo()
        
        self.backgroundColor = .smokyBlack
        
        self.addSubview(startBtn)
        startBtn.setTitle("Start", for: .normal)
        startBtn.setTitleColor(.cultured, for: .normal)
        startBtn.backgroundColor = .dodgerBlue
        startBtn.layer.cornerRadius = 4
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        startBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        startBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
