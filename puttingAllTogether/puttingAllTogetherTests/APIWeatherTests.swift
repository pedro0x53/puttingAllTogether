//
//  WeatherAPITests.swift
//  puttingAllTogetherTests
//
//  Created by Pedro Henrique Costa on 19/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import XCTest
@testable import puttingAllTogether

class WeatherAPITests: XCTestCase {

    var weatherAPI : WeatherAPI?
    
    override func setUp() {
        weatherAPI = WeatherAPI()
    }
    
    func test_weatherAPI_location_Lat10Lon10() {
        
        //Given
        weatherAPI?.setLocation(latitude: 10.0, longitude: 10.0)
        
        //When
        let lat = weatherAPI?.locationCoordinates.latitude
        let lon = weatherAPI?.locationCoordinates.longitude
        
        //Then
        XCTAssertEqual(lat, 10.0)
        XCTAssertEqual(lon, 10.0)
    }
    
    func test_weatherAPI_createURL_Lat10Lon10() {
        
        //Given
        weatherAPI?.locationCoordinates.latitude = 10.0
        weatherAPI?.locationCoordinates.longitude = 10.0
        
        //When
        let url = weatherAPI?.createURLString()
        
        //Then
        XCTAssertEqual(url, "https://api.openweathermap.org/data/2.5/weather?lat=10.0&lon=10.0&appid=9402f537f757e5a96e51fef8c3c29882")
        
    }
    
}
