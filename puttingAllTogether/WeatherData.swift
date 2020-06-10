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
    var icon : String
}

struct subSys : Codable {
    var type : Int
    var id : Int
    var country : String
    var sunrise : Double
    var sunset : Double
}

public struct WeatherData : Codable {
    var coord : Dictionary<String, Float>
    var weather : Array<subWeather>
    var base : String
    var main : Dictionary<String, Float>
    var visibility : Int
    var wind : Dictionary<String, Float>
    var clouds : Dictionary<String, Float>
    var dt : Double
    var sys : subSys
    var timezone : Int
    var id : Int
    var name : String
    var cod : Int
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
