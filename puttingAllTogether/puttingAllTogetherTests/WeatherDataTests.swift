//
//  WeatherDataTests.swift
//  puttingAllTogetherTests
//
//  Created by Pedro Henrique Costa on 16/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import XCTest
@testable import puttingAllTogether

class WeatherDataTests: XCTestCase {
    
    override func setUp() {
        WeatherData.shared.resetData()
    }
    
    func test_weatherData_placeName_Fortaleza() {
        //Given
        WeatherData.shared.name = "Fortaleza"
        
        //When
        let name = try! WeatherData.shared.getPlace()
        
        //Then
        XCTAssertEqual(name, "Fortaleza")
    }
    
    func test_weatherData_placeName_nil() {
        //Given
        WeatherData.shared.name = nil

        //When
        //let visibility = WeatherData.shared.getVisibility()

        //Then
        XCTAssertThrowsError(try WeatherData.shared.getPlace())
    }
    
    func test_weatherData_weatherMain_thunderstorm() {
        //Given
        WeatherData.shared.weather = [
            subWeather(id: 200, main: "Thunderstorm", description: "thunderstorm"),
        ]

        //When
        let weather = try! WeatherData.shared.getWeather()

        //Then
        XCTAssertEqual(weather, "Thunderstorm")
    }
    
    func test_weatherData_weatherMain_drizzle() {
        //Given
        WeatherData.shared.weather = [
            subWeather(id: 300, main: "Drizzle", description: "light rain"),
        ]

        //When
        let weather = try! WeatherData.shared.getWeather()

        //Then
        XCTAssertEqual(weather, "Drizzle")
    }
    
    func test_weatherData_weatherMain_rain() {
        //Given
        WeatherData.shared.weather = [
            subWeather(id: 500, main: "Rain", description: "light rain"),
        ]

        //When
        let weather = try! WeatherData.shared.getWeather()

        //Then
        XCTAssertEqual(weather, "Rain")
    }
    
    func test_weatherData_weatherMain_snow() {
        //Given
        WeatherData.shared.weather = [
            subWeather(id: 600, main: "Snow", description: "snow"),
        ]

        //When
        let weather = try! WeatherData.shared.getWeather()

        //Then
        XCTAssertEqual(weather, "Snow")
    }
    
    func test_weatherData_weatherMain_clear() {
        //Given
        WeatherData.shared.weather = [
            subWeather(id: 800, main: "Clear", description: "clear sky"),
        ]

        //When
        let weather = try! WeatherData.shared.getWeather()

        //Then
        XCTAssertEqual(weather, "Clear")
    }
    
    func test_weatherData_weatherMain_clouds() {
        //Given
        WeatherData.shared.weather = [
            subWeather(id: 801, main: "Clouds", description: "cloudy"),
        ]

        //When
        let weather = try! WeatherData.shared.getWeather()

        //Then
        XCTAssertEqual(weather, "Clouds")
    }
    
    func test_weatherData_weatherMain_default() {
        //Given
        WeatherData.shared.weather = [
            subWeather(id: 999, main: "Clear", description: "clear sky"),
        ]

        //When
        let weather = try! WeatherData.shared.getWeather()

        //Then
        XCTAssertEqual(weather, "Clear")
    }
    
    func test_weatherData_weatherMain_nil() {
        //Given
        WeatherData.shared.weather = nil

        //When
        //let visibility = WeatherData.shared.getVisibility()

        //Then
        XCTAssertThrowsError(try WeatherData.shared.getWeather())
    }

    func test_weatherData_temperature_celsiusBoiling() {
        //Given
        WeatherData.shared.main = [
            "temp": 373.15,
            "feels_like": 301.3,
            "temp_min": 280.15,
            "temp_max": 304.15,
            "pressure": 1014,
            "humidity": 58
        ]

        //When
        let temp = try! WeatherData.shared.getTemperature(in: "Celsius")

        //Then
        XCTAssertEqual(temp, 100, accuracy: 0.01)
    }
    
    func test_weatherData_temperature_fahrenheitBoiling() {
        //Given
        WeatherData.shared.main = [
            "temp": 373.15,
            "feels_like": 301.3,
            "temp_min": 280.15,
            "temp_max": 304.15,
            "pressure": 1014,
            "humidity": 58
        ]

        //When
        let temp = try! WeatherData.shared.getTemperature(in: "Fahrenheit")

        //Then
        XCTAssertEqual(temp, 212, accuracy: 0.01)
    }
    
    func test_weatherData_temperature_nil() {
        //Given
        WeatherData.shared.main = nil

        //When
        //let visibility = WeatherData.shared.getVisibility()

        //Then
        XCTAssertThrowsError(try WeatherData.shared.getTemperature())
    }

    func test_weatherData_wind_100ms() {
        //Given
        WeatherData.shared.wind = [
            "speed": 100,
            "deg": 90
        ]
        
        //When
        let windSpeed = try! WeatherData.shared.getWindSpeed()
        
        //Then
        XCTAssertEqual(windSpeed, 100)
    }
    
    func test_weatherData_wind_nil() {
        //Given
        WeatherData.shared.wind = nil

        //When
        //let visibility = WeatherData.shared.getVisibility()

        //Then
        XCTAssertThrowsError(try WeatherData.shared.getWindSpeed())
    }
    
    func test_weatherData_cloudiness_halfCover() {
        //Given
        WeatherData.shared.clouds = [
            "all": 50
        ]

        //When
        let clouds = try! WeatherData.shared.getCloudiness()

        //Then
        XCTAssertEqual(clouds, 50)
    }

    func test_weatherData_cloudiness_nil() {
        //Given
        WeatherData.shared.clouds = nil

        //When
        //let visibility = WeatherData.shared.getVisibility()

        //Then
        XCTAssertThrowsError(try WeatherData.shared.getCloudiness())
    }
    
    func test_weatherData_visibility_10kMeters() {
        //Given
        WeatherData.shared.visibility = 10000

        //When
        let visibility = try! WeatherData.shared.getVisibility()

        //Then
        XCTAssertEqual(visibility, 10000)
    }
    
    func test_weatherData_visibility_nil() {
        //Given
        WeatherData.shared.visibility = nil

        //When
        //let visibility = WeatherData.shared.getVisibility()

        //Then
        XCTAssertThrowsError(try WeatherData.shared.getVisibility())
    }

}

