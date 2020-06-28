//
//  Credits.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 25/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class Credits: UIView {
    
    let mainTile: UILabel = UILabel()

    init() {
        super.init(frame: UIScreen.main.bounds)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .smokyBlack
        
        self.addSubview(mainTile)
        mainTile.text = "Créditos"
        mainTile.textColor = .cultured
        mainTile.font = UIFont.systemFont(ofSize: 34, weight: .regular)
        mainTile.translatesAutoresizingMaskIntoConstraints = false
        mainTile.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        mainTile.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        let plotTitle = UILabel()
        self.addSubview(plotTitle)
        plotTitle.text = "Enredo"
        plotTitle.textColor = .cultured
        plotTitle.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        plotTitle.translatesAutoresizingMaskIntoConstraints = false
        plotTitle.topAnchor.constraint(equalTo: mainTile.bottomAnchor, constant: 40).isActive = true
        plotTitle.centerXAnchor.constraint(equalTo: mainTile.centerXAnchor).isActive = true
        
        let plotContent = UILabel()
        self.addSubview(plotContent)
        plotContent.textAlignment = .center
        plotContent.text = "Escrito por Carlos Erickson"
        plotContent.numberOfLines = 5
        plotContent.textColor = .cultured
        plotContent.translatesAutoresizingMaskIntoConstraints = false
        plotContent.topAnchor.constraint(equalTo: plotTitle.bottomAnchor, constant: 20).isActive = true
        plotContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        plotContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        let voicesTitle = UILabel()
        self.addSubview(voicesTitle)
        voicesTitle.text = "Vozes"
        voicesTitle.textColor = .cultured
        voicesTitle.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        voicesTitle.translatesAutoresizingMaskIntoConstraints = false
        voicesTitle.topAnchor.constraint(equalTo: plotContent.bottomAnchor, constant: 40).isActive = true
        voicesTitle.centerXAnchor.constraint(equalTo: mainTile.centerXAnchor).isActive = true
        
        let voicesContent = UILabel()
        self.addSubview(voicesContent)
        voicesContent.textAlignment = .center
        voicesContent.text = "Lucas   como  Character\nPedro    como  Character"
        voicesContent.numberOfLines = 5
        voicesContent.textColor = .cultured
        voicesContent.translatesAutoresizingMaskIntoConstraints = false
        voicesContent.topAnchor.constraint(equalTo: voicesTitle.bottomAnchor, constant: 20).isActive = true
        voicesContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        voicesContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        let developersTitle = UILabel()
        self.addSubview(developersTitle)
        developersTitle.text = "Time de Desenvolvimento"
        developersTitle.textColor = .cultured
        developersTitle.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        developersTitle.translatesAutoresizingMaskIntoConstraints = false
        developersTitle.topAnchor.constraint(equalTo: voicesContent.bottomAnchor, constant: 40).isActive = true
        developersTitle.centerXAnchor.constraint(equalTo: mainTile.centerXAnchor).isActive = true
        
        let developersContent = UILabel()
        self.addSubview(developersContent)
        developersContent.textAlignment = .center
        developersContent.text = "Hiago chagas\nHenrique Costa\nLucas Fernandes\nPedro Sousa"
        developersContent.numberOfLines = 5
        developersContent.textColor = .cultured
        developersContent.translatesAutoresizingMaskIntoConstraints = false
        developersContent.topAnchor.constraint(equalTo: developersTitle.bottomAnchor, constant: 20).isActive = true
        developersContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        developersContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }

}
