//
//  LocationTests.swift
//  ToDo
//
//  Created by Emmanuel Francisco Tugado on 14/1/17.
//  Copyright © 2017 Emmanuel Tugado. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_shouldSetNameAndCoordinate() {
        let testCoordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "Test name", coordinate: testCoordinate)
        XCTAssertEqual(testCoordinate.latitude, location.coordinate?.latitude)
        XCTAssertEqual(testCoordinate.longitude, location.coordinate?.longitude)
    }
    
    func testEqualLocations_ShouldBeEqual() {
        let firstLocation = Location(name: "Home")
        let secondLocation = Location(name: "Home")
        
        XCTAssertEqual(firstLocation, secondLocation)
    }
    
    func testWhenLatitudesDiffer_ShouldNotBeEqual() {
        performNotEqualTestWithLocationProperties(firstName: "Home", secondName: "Home", firstLongLat: (0.0, 0.0), secondLongLat: (1.0, 0.0))
    }
    
    func testWhenLongitudesDiffer_ShouldNotBeEqual() {
        performNotEqualTestWithLocationProperties(firstName: "Home", secondName: "Home", firstLongLat: (0.0, 1.0), secondLongLat: (0.0, 0.0))
    }
    
    func testWhenOneLocationHasCoordinateAndTheOtherDoesnt_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties(firstName: "Home", secondName: "Home", firstLongLat: nil, secondLongLat: (0.0, 0.0))
    }
    
    func testWhenNameDiffers_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties(firstName: "Home", secondName: "Office", firstLongLat: nil, secondLongLat: nil)
    }
    
    func performNotEqualTestWithLocationProperties(firstName: String, secondName: String, firstLongLat: (Double, Double)?, secondLongLat: (Double, Double)?, line: UInt = #line) {
        let firstCoord: CLLocationCoordinate2D?
        if let firstLongLat = firstLongLat {
            firstCoord = CLLocationCoordinate2D(latitude: firstLongLat.0, longitude: firstLongLat.1)
        } else {
            firstCoord = nil
        }
        let firstLocation = Location(name: firstName, coordinate: firstCoord)
        
        let secondCoord: CLLocationCoordinate2D?
        if let secondLongLat = secondLongLat {
            secondCoord = CLLocationCoordinate2D(latitude: secondLongLat.0, longitude: secondLongLat.1)
        } else {
             secondCoord = nil
        }
        let secondLocation = Location(name: secondName, coordinate: secondCoord)
        
        XCTAssertNotEqual(firstLocation, secondLocation, line: line)
    }
    
    func test_CanBeSerializedAndDeserialized() {
        let location = Location(name: "Home", coordinate: CLLocationCoordinate2DMake(50.0, 6.0))
        
        let dict = location.plistDict
        
        XCTAssertNotNil(dict)
        
        let recreatedLocation = Location(dict: dict)
        XCTAssertEqual(location, recreatedLocation)
    }
}
