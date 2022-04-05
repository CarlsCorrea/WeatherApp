//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Carlos Correa on 31/03/2022.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    private var weatherServices: WeatherService!
    private var locationServices: LocationService!
    private var mockLocationManager: MockLocationManager!
    private var testSubject: LocationManager!
    private var mockLocation = Location(latitude: 0, longitude:0)

    override func setUp() {
        super.setUp()
        self.mockLocationManager = MockLocationManager()
        self.locationServices = LocationService(locationManager: mockLocationManager)
    }
    
    override func tearDown() {
        self.testSubject = nil
        self.weatherServices = nil
        self.locationServices = nil
        self.mockLocationManager = nil
        super.tearDown()
    }

    func test_Given_CorrectLocation_When_FetchUserLocation_Then_Success() {
        self.mockLocation = Location(latitude: 51.509865, longitude: -0.118092)
        self.locationServices.fetchUserLocation() { result in
            switch result {
            case .success(let location):
                XCTAssertEqual(self.mockLocation.latitude, location.latitude)
            case .failure(let error):
                XCTAssertEqual(error, nil)
            }
        }
    }
    
    func test_Given_CorrectWrong_When_FetchUserLocation_Then_Error() {
        self.mockLocation = Location(latitude: -29.670000000000002, longitude: -0.118092)
        self.locationServices.fetchUserLocation() { result in
            switch result {
            case .success(let location):
                XCTAssertNotEqual(self.mockLocation.latitude, location.latitude)
            case .failure(let error):
                XCTAssertEqual(error, nil)
            }
        }
    }
        
}
