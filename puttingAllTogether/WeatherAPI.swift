//
//  weatherAPI.swift
//  testAPI
//
//  Created by Pedro Henrique Costa on 03/06/20.
//  Copyright © 2020 Pedro Henrique Costa. All rights reserved.
//

import Foundation
import CoreLocation

public class WeatherAPI {
    var info : WeatherData?
    
    var locationCoordinates = (latitude : 0.0, longitude : 0.0)
    let APIKey = "9402f537f757e5a96e51fef8c3c29882"
    var weatherURLString = ""
   
    //MARK: - Update User Location
    
    func setLocation(latitude lat : Double, longitude lon : Double) {
        locationCoordinates.latitude = lat
        locationCoordinates.longitude = lon
    }
    
    //MARK: - OpenWeatherMap API Request
    
    private func createURLString() {
        weatherURLString = "https://api.openweathermap.org/data/2.5/weather?lat=\(locationCoordinates.latitude)&lon=\(locationCoordinates.longitude)&appid=\(APIKey)"
    }
    
    func weatherRequestInfo() {
        createURLString()
        
        let url = URL(string: weatherURLString)!
        
        //Semáforo só até saber onde tratar a requisição assíncrona
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Client error!")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error!")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.info = try decoder.decode(WeatherData.self, from: data!)
                semaphore.signal()
            } catch {
                print(error)
            }
        }
        
        task.resume()
        
        semaphore.wait()
    }
    
    //MARK: - Print for Tests
    
    func printAllInfo() {
        print("Weather: \(getWeather())")
        print("Temperature: \(getCelsiusTemperature()) Celsius")
        print("Wind Speed: \(getWindSpeed()) m/s")
        print("Clouds: \(getCloudiness())%")
        print("Visibility: \(getVisibility()) meters")
    }
    
    //MARK: - Game Requests
    
    func getWeather() -> String {
        guard info != nil else {
            fatalError("No weather information in memory!")
        }
        
        let weatherId = info?.weather[0].id
        
        switch weatherId! {
            case 200...232:
                return "Thunderstorm"
            case 300...321:
                return "Drizzle"
            case 500...531:
                return "Rain"
            case 600...622:
                return "Snow"
            case 800:
                return "Clear"
            case 801...804:
                return "Clouds"
            default:
                return "Clear"
        }
    }
    
    //Visibilidade em metros
    func getVisibility() -> Int {
        if let visibility = info?.visibility {
            return visibility
        } else {
            fatalError("No visibility information in memory!")
        }
    }
    
    //Velocidade do vento em metros por segundo
    func getWindSpeed() -> Float {
        if let wind = info?.wind["speed"] {
            return wind
        } else {
            fatalError("No wind information in memory!")
        }
    }
    
    //Nuvens em percentual do céu coberto
    func getCloudiness() -> Float {
        if let clouds = info?.clouds["all"] {
            return clouds
        } else {
            fatalError("No cloud information in memory!")
        }
    }
    
    func getCelsiusTemperature() -> Float {
        guard info != nil else {
            fatalError("No temperature information in memory!")
        }
        
        let kelvinTemp = info?.main["temp"]
        let celsiusTemp = kelvinTemp! - 273.15
        return celsiusTemp
    }
    
    func getFahrenheitTemperature() -> Float {
        guard info != nil else {
            fatalError("No temperature information in memory!")
        }
        
        let celsiusTemp = getCelsiusTemperature()
        let fahrenheitTemp = 32 + (9*celsiusTemp)/5
        return fahrenheitTemp
    }
    
}
