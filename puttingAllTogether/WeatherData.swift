//
//  weatherInfo.swift
//  testAPI
//
//  Created by Pedro Henrique Costa on 02/06/20.
//  Copyright © 2020 Pedro Henrique Costa. All rights reserved.
//

import Foundation

struct subWeather : Codable {
    var id : Int
    var main : String
    var description : String
}

class WeatherData : Codable {
    static var shared = WeatherData()
    
    var weather : Array<subWeather>?
    var main : Dictionary<String, Float>?
    var visibility : Int?
    var wind : Dictionary<String, Float>?
    var clouds : Dictionary<String, Float>?
    var name : String?
    
    private init() {}
    
    func printTest() {
        print("""
        Place: \(getPlace())
        Weather: \(getWeather())
        Temperature: \(getCelsiusTemperature()) Celsius
        Wind Speed: \(getWindSpeed()) m/s
        Cloudiness: \(getCloudiness()) percent coverage
    """)
    }
    
    func resetData() {
        weather = nil
        main = nil
        visibility = nil
        wind = nil
        clouds = nil
        name = nil
    }
    
    func getPlace() -> String {
        if let placeName = name {
            return placeName
        } else {
            fatalError("No place information in memory!")
        }
    }
    
    func getWeather() -> String {
        if let weatherId = weather?[0].id {
            switch weatherId {
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
        } else {
            fatalError("No weather information in memory!")
        }
    }
    
    //Visibilidade em metros
    func getVisibility() -> Int {
        if let visibility = visibility {
            return visibility
        } else {
            fatalError("No visibility information in memory!")
        }
    }
    
    //Velocidade do vento em metros por segundo
    func getWindSpeed() -> Float {
        if let wind = wind?["speed"] {
            return wind
        } else {
            fatalError("No wind information in memory!")
        }
    }
    
    //Nuvens em percentual do céu coberto
    func getCloudiness() -> Float {
        if let clouds = clouds?["all"] {
            return clouds
        } else {
            fatalError("No cloud information in memory!")
        }
    }
    
    func getCelsiusTemperature() -> Float {
        if let kelvinTemp = main?["temp"] {
            let celsiusTemp = kelvinTemp - 273.15
            return celsiusTemp
        } else {
            fatalError("No cloud information in memory!")
        }
    }
    
    func getFahrenheitTemperature() -> Float {
        if let kelvinTemp = main?["temp"] {
            let fahrenheitTemp = -459.67 + (9*kelvinTemp)/5
            return fahrenheitTemp
        } else {
            fatalError("No temperature information in memory!")
        }
        
        
    }
    
}

//MARK: - Reference for API response

/*
{
    "coord": {
        "lon": 139,
        "lat": 35
    },
    "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01n"
    }
    ],
    "base": "stations",
    "main": {
        "temp": 303.25,
        "feels_like": 301.3,
        "temp_min": 280.15,
        "temp_max": 304.15,
        "pressure": 1014,
        "humidity": 58
    },
    "visibility":10000,
    "wind": {
        "speed": 8.7,
        "deg": 90
    },
    "clouds": {
        "all": 40
    },
    "dt": 1591198180,
    "sys": {
        "type": 1,
        "id": 8363,
        "country": "BR",
        "sunrise": 1591173301,
        "sunset": 1591216196
    },
    "timezone": -10800,
    "id": 6320062,
    "name": "Fortaleza",
    "cod": 200
}
*/
