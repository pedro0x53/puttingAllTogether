//
//  ManagerDelegate.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 15/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit
import AVFoundation

protocol ManagerDelegate: UIGestureRecognizerDelegate, AVAudioPlayerDelegate {
    func playerDidFinished()
    func gestureRecognized()
}
