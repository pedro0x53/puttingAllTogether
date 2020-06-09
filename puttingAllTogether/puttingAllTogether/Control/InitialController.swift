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
    
    var initial = Initial()
    
    let locationManager = CLLocationManager()
    let weatherData = WeatherAPI()
    
    override func loadView() {
        view = initial
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
            locationManager.requestLocation()
        }
        
        setupActions()
    }
    
    private func setupActions() {
        self.initial.startBtn.addTarget(
            self,
            action: #selector(start),
            for: .touchUpInside)
    }
    
    @objc private func start() {
        let gameplayController = GameplayController()
        self.navigationController?.pushViewController(gameplayController, animated: true)
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
        print("SHIT")
    }
    
}
