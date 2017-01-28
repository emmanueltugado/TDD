//
//  ToDoItemTests.swift
//  ToDo
//
//  Created by Emmanuel Francisco Tugado on 14/1/17.
//  Copyright © 2017 Emmanuel Tugado. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit_ShouldSetTitle() {
        let item = ToDoItem(title: "Test title")
        XCTAssertEqual(item.title, "Test title")
    }
    
    func testInit_shouldSetTitleAndDescription() {
        let item = ToDoItem(title: "Test title", description: "Test description")
        XCTAssertEqual(item.description, "Test description")
    }
    
    func testInit_shouldSetTitleAndDescriptionAndTimeStamp() {
        let item = ToDoItem(title: "Test title", description: "Test description", timestamp: 0.0)
        XCTAssertEqual(item.timestamp, 0.0)
    }
    
    func testInit_shouldSetTitleAndDescriptionAndTimeStampAndLocation() {
        let location = Location(name: "Test name")
        let item = ToDoItem(title: "Test title", description: "Test description", timestamp: 0.0, location: location)
        
        XCTAssertEqual(location.name, item.location?.name)
    }
    
    func testEqualItems_ShouldBeEqual() {
        let firstItem = ToDoItem(title: "item")
        let secondItem = ToDoItem(title: "item")
        
        XCTAssertEqual(firstItem, secondItem)
    }
    
    func testWhenLocationDiffers_ShouldNotBeEqual() {
        let firstItem = ToDoItem(title: "First title", description: "First desc", timestamp: 0.0, location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "First title", description: "First desc", timestamp: 0.0, location: Location(name: "Office"))
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenOneLocationIsNilAndTheOtherIsnt_ShouldNotBeEqual() {
        let firstItem = ToDoItem(title: "First title", description: "First desc", timestamp: 0.0, location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "First title", description: "First desc", timestamp: 0.0, location: nil)
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTimestampDiffers_ShouldNotBeEqual() {
        let firstItem = ToDoItem(title: "First title", description: "First desc", timestamp: 0.0, location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "First title", description: "First desc", timestamp: 1.0, location: Location(name: "Home"))
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenDescriptionDiffers_ShouldNotBeEqual() {
        let firstItem = ToDoItem(title: "First title", description: "First desc", timestamp: 0.0, location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "First title", description: "Second desc", timestamp: 0.0, location: Location(name: "Home"))
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTitleDiffers_ShouldNotBeEqual() {
        let firstItem = ToDoItem(title: "First title", description: "First desc", timestamp: 0.0, location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "Second title", description: "First desc", timestamp: 0.0, location: Location(name: "Home"))
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func test_HasPlistDictionaryProperty() {
        let item = ToDoItem(title: "First")
        let dictionary = item.plistDict
        
        XCTAssertNotNil(dictionary)
        XCTAssertTrue(dictionary is [String: Any])
    }
    
    func test_CanBeCreatedFromPlistDictionary() {
        let location = Location(name: "Bar")
        let item = ToDoItem(title: "Foo", description: "Baz", timestamp: 1.0, location: location)
        
        let dict = item.plistDict
        let recreatedItem = ToDoItem(dict: dict)
        
        XCTAssertEqual(item, recreatedItem)
    }
}
