//
//  InitialController.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 02/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

class InitialController: UIViewController {
    
    let initial = Initial()
    
    let locationManager = CLLocationManager()
    let audioManager = AudioManager.shared
    
    public static var menu: [MenuItem] = MenuManager.getMenu(type: .initial)
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func loadView() {
        super.loadView()
        view = initial
        initial.menu.delegate = self
        initial.menu.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
            locationManager.requestLocation()
        } else {
            WeatherData.shared.setDefaultData()
//            WeatherData.shared.printTest()
        }
        audioManager.play(player: .loop, urlString: "theInvestigation")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension InitialController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return InitialController.menu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
        
        cell.configure(label: InitialController.menu[indexPath.row].label,
                       icon: InitialController.menu[indexPath.row].icon)
        
        let action = InitialController.menu[indexPath.row].action
        switch action {
        case .start:
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(start)))
        case .resume:
            break
        case .preferences:
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(preferences)))
        case .exit:
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exit)))
        }
        return cell
    }
    
    @objc private func start() {
        let controller = GameplayController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func preferences() {
        let controller = PreferencesController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func exit() {
        print("Exit Selector")
    }
}

extension InitialController : CLLocationManagerDelegate {
    
    func retrieveCurrentLocation() {
        let status = CLLocationManager.authorizationStatus()
        
        if status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled() {
            print("Location services not allowed")
            return
        }
        
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
        
        switch status {
            case .authorizedAlways:
                print("user allow app to get location data when app is active or in background")
            case .authorizedWhenInUse:
                print("user allow app to get location data only when app is active")
            case .denied:
                print("user tap 'disallow' on the permission dialog, cant get location data")
            case .restricted:
                print("parental control setting disallow location data")
            case .notDetermined:
                print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
            default:
                fatalError("Unknown location authorization status!")
        }
        
        if(status == .authorizedWhenInUse || status == .authorizedAlways){
          manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let weatherAPI = WeatherAPI()
            weatherAPI.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            weatherAPI.weatherInfoRequest()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in getting location: Location Services probably disabled")
    }
    
}
