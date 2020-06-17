//
//  MenuCell.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 16/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

public enum Actions {
    case start
    case resume
    case preferences
    case exit
}

public class MenuItem {
    var icon: String
    var label: String
    var action: Actions
    
    init(icon: String, label: String, action: Actions) {
        self.icon = icon
        self.label = label
        self.action = action
    }
}

class MenuCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    public static var identifier: String = "menuItem"
    
    private var label: UILabel = UILabel()
    private var iconView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
    private var icon: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .smokyBlackA
        self.layer.cornerRadius = 30
        
        self.addSubview(iconView)
        iconView.layer.cornerRadius = 70
        iconView.layer.borderWidth = 2
        iconView.layer.borderColor = UIColor.dodgerBlue.cgColor
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20).isActive = true
        iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        iconView.addSubview(icon)
        icon.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.addSubview(label)
        label.textColor = .dodgerBlue
        label.font = UIFont.systemFont(ofSize: 35, weight: .thin)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 15).isActive = true
        label.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
    }
    
    public func configure(label: String, icon: String) {
        self.label.text = label
        self.icon.image = UIImage(named: icon)
    }
}
