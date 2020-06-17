//
//  Menu.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 16/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class Menu: UICollectionView {
    
    public static let shared = Menu()
    
    private static let layout: UICollectionViewLayout = {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .absolute(300))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: Menu.layout)
        setupLayout()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
    
    private func registerCell() {
        self.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
    }
}
