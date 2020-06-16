//
//  InitialController.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 02/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit
import CoreLocation

class InitialController: UIViewController {
    
    let initial = Initial()
    
    let locationManager = CLLocationManager()
    let weatherData = WeatherAPI()
    
    private let menu = [
        MenuItem(icon: "play_icon", label: "Play"),
        MenuItem(icon: "settings_icon", label: "Preferências"),
        MenuItem(icon: "copyright_icon", label: "Créditos"),
        MenuItem(icon: "exit_icon", label: "Sair")
    ]
    
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
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

extension InitialController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
        cell.configure(data: self.menu[indexPath.row])
        return cell
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
            weatherData.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            weatherData.weatherRequestInfo()
            weatherData.printAllInfo()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in getting location: Location Services probably disabled")
    }
    
}
