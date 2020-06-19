//
//  weatherAPI.swift
//  testAPI
//
//  Created by Pedro Henrique Costa on 03/06/20.
//  Copyright © 2020 Pedro Henrique Costa. All rights reserved.
//

import Foundation

class WeatherAPI {
    
    var locationCoordinates = (latitude : 0.0, longitude : 0.0)
    let APIKey = "9402f537f757e5a96e51fef8c3c29882"
   
    //MARK: - Update User Location
    
    func setLocation(latitude lat : Double, longitude lon : Double) {
        locationCoordinates.latitude = lat
        locationCoordinates.longitude = lon
    }
    
    //MARK: - OpenWeatherMap API Request
    
    func createURLString() -> String {
        return "https://api.openweathermap.org/data/2.5/weather?lat=\(locationCoordinates.latitude)&lon=\(locationCoordinates.longitude)&appid=\(APIKey)"
    }
    
    func weatherInfoRequest() {
        
        let url = URL(string: createURLString())!
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Client error!")
                WeatherData.shared.setDefaultData()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error!")
                WeatherData.shared.setDefaultData()
                return
            }
            
            let decoder = JSONDecoder()
            do {
                WeatherData.shared = try decoder.decode(WeatherData.self, from: data!)
                semaphore.signal()
            } catch {
                print(error)
            }
        }
        
        task.resume()
        
        semaphore.wait()
        
//        WeatherData.shared.printTest()
    }
    
}
