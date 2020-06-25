//
//  PreferencesController.swift
//  puttingAllTogether
//
//  Created by Hiago Chagas on 11/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit
import AVFoundation

class PreferencesController: UIViewController {
    //preferences view
    
    var preferences = Preferences()
    var audioManager = AudioManager.shared
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func loadView() {
        super.loadView()
        view = preferences
        
        preferences.generalVolumeSlider.value = audioManager.sfxVolume
        preferences.generalVolumeSlider.addTarget(self, action: #selector(didSlideSliderGeneral(_:)), for: .valueChanged)
        preferences.dubbingVolumeSlider.value = audioManager.sceneVolume
        preferences.dubbingVolumeSlider.addTarget(self, action: #selector(didSlideSliderDubbing(_:)), for: .valueChanged)
        preferences.effectsVolumeSlider.value = audioManager.loopVolume
        preferences.effectsVolumeSlider.addTarget(self, action: #selector(didSlideSliderEffects(_:)), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Preferências"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func didSlideSliderGeneral(_ slider: UISlider) {
        let value = slider.value
        audioManager.loopVolume = value
    }
    
    @objc func didSlideSliderDubbing(_ slider: UISlider) {
        let value = slider.value
        audioManager.sceneVolume = value
    }
    
    @objc func didSlideSliderEffects(_ slider: UISlider) {
        let value = slider.value
        audioManager.sfxVolume = value
    }
}
