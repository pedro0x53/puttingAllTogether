//
//  Preferences.swift
//  puttingAllTogether
//
//  Created by Hiago Chagas on 09/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit

class Preferences: UIView {
    //still needed to set the current values of each slider
    let bkg: UIImageView = UIImageView(image: UIImage(named: "bkg"))
    
    let volumesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Volumes"
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.textColor = .white
        return lbl
    }()
    let generalLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Geral"
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = .white
        return lbl
    }()
    let generalVolumeSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .dodgerBlue
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.heightAnchor.constraint(equalToConstant: 22).isActive = true
        slider.tintColor = .gray
        slider.minimumValueImage = UIImage(systemName: "speaker.fill") //change to proper icon
        slider.maximumValueImage = UIImage(systemName: "speaker.3.fill") //change to proper icon
        slider.minimumTrackTintColor = .systemBlue
        return slider
    }()
    let dubbingLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Dublagem"
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = .white
        return lbl
    }()
    let dubbingVolumeSlider: UISlider = {
       let slider = UISlider()
        slider.tintColor = .dodgerBlue
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.heightAnchor.constraint(equalToConstant: 22).isActive = true
        slider.tintColor = .gray
        slider.minimumValueImage = UIImage(systemName: "speaker.fill") //change to proper icon
        slider.maximumValueImage = UIImage(systemName: "speaker.3.fill") //change to proper icon
        slider.minimumTrackTintColor = .systemBlue
        return slider
    }()
    let effectsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Efeitos"
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = .white
        return lbl
    }()
    let effectsVolumeSlider: UISlider = {
       let slider = UISlider()
        slider.tintColor = .dodgerBlue
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.heightAnchor.constraint(equalToConstant: 22).isActive = true
        slider.tintColor = .gray
        slider.minimumValueImage = UIImage(systemName: "speaker.fill") //change to proper icon
        slider.maximumValueImage = UIImage(systemName: "speaker.3.fill") //change to proper icon
        slider.minimumTrackTintColor = .systemBlue
        return slider
    }()
    let talkbackLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Talkback"
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.textColor = .white
        return lbl
    }()
    let talkbackDescriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Voz assistente do jogo"
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = .gray
        return lbl
    }()
    let talkbackSwitch: UISwitch = {
        let swt = UISwitch()
        swt.onTintColor = .dodgerBlue
        return swt
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        self.addSubview(bkg)
        bkg.clipsToBounds = true
        bkg.contentMode = UIView.ContentMode.center
        bkg.frame.size.width = UIScreen.main.bounds.width
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = bkg.bounds
        self.addSubview(blurredEffectView)
        
        addToView(view: volumesLabel, topAnchor: self.safeAreaLayoutGuide.topAnchor, botAnchor: nil, leftAnchor: self.leftAnchor, rightAnchor: nil, topSpacing: 16, leftSpacing: 20, rightSpacing: 0, downSpacing: 0)
        
        addToView(view: generalLabel, topAnchor: volumesLabel.bottomAnchor, botAnchor: nil, leftAnchor: volumesLabel.leftAnchor, rightAnchor: nil, topSpacing: 16, leftSpacing: 0, rightSpacing: 0, downSpacing: 0)
        addToView(view: generalVolumeSlider, topAnchor: generalLabel.bottomAnchor, botAnchor: nil, leftAnchor: generalLabel.leftAnchor, rightAnchor: self.rightAnchor, topSpacing: 15, leftSpacing: 0, rightSpacing: -20, downSpacing: 0)
        
        addToView(view: dubbingLabel, topAnchor: generalVolumeSlider.bottomAnchor, botAnchor: nil, leftAnchor: volumesLabel.leftAnchor, rightAnchor: nil, topSpacing: 30, leftSpacing: 0, rightSpacing: 0, downSpacing: 0)
        addToView(view: dubbingVolumeSlider, topAnchor: dubbingLabel.bottomAnchor, botAnchor: nil, leftAnchor: dubbingLabel.leftAnchor, rightAnchor: self.rightAnchor, topSpacing: 15, leftSpacing: 0, rightSpacing: -16, downSpacing: 0)
        
        addToView(view: effectsLabel, topAnchor: dubbingVolumeSlider.bottomAnchor, botAnchor: nil, leftAnchor: volumesLabel.leftAnchor, rightAnchor: nil, topSpacing: 30, leftSpacing: 0, rightSpacing: 0, downSpacing: 0)
        addToView(view: effectsVolumeSlider, topAnchor: effectsLabel.bottomAnchor, botAnchor: nil, leftAnchor: effectsLabel.leftAnchor, rightAnchor: self.rightAnchor, topSpacing: 15, leftSpacing: 0, rightSpacing: -16, downSpacing: 0)
        
        addToView(view: talkbackLabel, topAnchor: effectsVolumeSlider.bottomAnchor, botAnchor: nil, leftAnchor: volumesLabel.leftAnchor, rightAnchor: nil, topSpacing: 50, leftSpacing: 0, rightSpacing: 0, downSpacing: 0)
        addToView(view: talkbackDescriptionLabel, topAnchor: talkbackLabel.bottomAnchor, botAnchor: nil, leftAnchor: volumesLabel.leftAnchor, rightAnchor: nil, topSpacing: 7, leftSpacing: 0, rightSpacing: 0, downSpacing: 0)
        addToView(view: talkbackSwitch, topAnchor: nil, botAnchor: nil, leftAnchor: nil, rightAnchor: self.rightAnchor, topSpacing: 0, leftSpacing: 0, rightSpacing: -16, downSpacing: 0)
        
        talkbackSwitch.centerYAnchor.constraint(equalTo: talkbackDescriptionLabel.centerYAnchor).isActive = true
    }
    //adds an UIView to self and sets its constraints
    func addToView(view: UIView, topAnchor: NSLayoutYAxisAnchor?, botAnchor: NSLayoutYAxisAnchor?, leftAnchor: NSLayoutXAxisAnchor?, rightAnchor: NSLayoutXAxisAnchor?, topSpacing: CGFloat, leftSpacing: CGFloat, rightSpacing: CGFloat, downSpacing: CGFloat){
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        if ((leftAnchor) != nil){
            view.leftAnchor.constraint(equalTo: leftAnchor!, constant: leftSpacing).isActive = true
        }
        if ((rightAnchor) != nil){
            view.rightAnchor.constraint(equalTo: rightAnchor!, constant: rightSpacing).isActive = true
        }
        if ((topAnchor) != nil){
            view.topAnchor.constraint(equalTo: topAnchor!, constant: topSpacing).isActive = true
        }
        if ((botAnchor) != nil){
            view.bottomAnchor.constraint(equalTo: botAnchor!, constant: downSpacing).isActive = true
        }
    }
}
