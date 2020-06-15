//
//  ManagerDelegate.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 15/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

protocol ManagerDelegate: UIGestureRecognizerDelegate {
    func playerDidFinished()
    func gestureRecognized()
}
