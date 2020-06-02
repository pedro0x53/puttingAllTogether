//
//  MainViewController.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 02/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class Initial: UIViewController {
    
    let btn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .smokyBlack
        view.addSubview(btn)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        btn.setTitle("Start", for: .normal)
        btn.setTitleColor(.cultured, for: .normal)
        btn.backgroundColor = .dodgerBlue
        btn.layer.cornerRadius = 4
        
        btn.addTarget(self, action: #selector(start), for: .touchUpInside)
    }
    
    @objc private func start() {
        let gameplay = Gameplay()
        self.navigationController?.pushViewController(gameplay, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
