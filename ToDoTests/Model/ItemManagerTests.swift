//
//  ItemManagerTests.swift
//  ToDo
//
//  Created by Emmanuel Francisco Tugado on 14/1/17.
//  Copyright © 2017 Emmanuel Tugado. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemManagerTests: XCTestCase {
    
    var sut: ItemManager!
    
    override func setUp() {
        super.setUp()
        
        sut = ItemManager()
    }
    
    override func tearDown() {
        sut.removeAllItems()
        sut = nil
        
        super.tearDown()
    }
    
    func testToDoCount_InitiallyShouldBeZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }
    
    func testDoneCount_InitiallyShouldBeZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func testDoCount_AfterAddingOneItem_IsOne() {
        sut.addItem(item: ToDoItem(title: "Test title"))
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func testItemAtIndex_ShouldReturnPreviouslyAddedItem() {
        let item = ToDoItem(title: "Test title")
        sut.addItem(item: item)
        
        let returnedItem = sut.itemAtIndex(index: 0)
        XCTAssertEqual(item.title, returnedItem.title)
    }
    
    func testCheckingItem_ChangeCountOfToDoAndDoneItems() {
        sut.addItem(item: ToDoItem(title: "Test title"))
        sut.checkItemAtIndex(index: 0)
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    func testCheckingItem_RemovesItFromTheToDoItemList() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        
        sut.addItem(item: firstItem)
        sut.addItem(item: secondItem)
        sut.checkItemAtIndex(index: 0)
        
        XCTAssertEqual(sut.itemAtIndex(index: 0).title, secondItem.title)
    }
    
    func testDoneItemAtIndex_ShouldReturnPreviouslyCheckedItem() {
        let item = ToDoItem(title: "item")
        
        sut.addItem(item: item)
        sut.checkItemAtIndex(index: 0)
        
        let returnedItem = sut.doneItemAtIndex(index: 0)
        
        XCTAssertEqual(item.title, returnedItem.title)
    }
    
    func testRemoveAllItems_ShouldResultInCountsBeZero() {
        sut.addItem(item: ToDoItem(title: "First"))
        sut.addItem(item: ToDoItem(title: "Second"))
        
        sut.removeAllItems()
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func testAddingTheSameItem_DoesNotIncreaseCount() {
        sut.addItem(item: ToDoItem(title: "First"))
        sut.addItem(item: ToDoItem(title: "First"))
        
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func test_ToDoItemsGetSerialized() {
        var itemManager: ItemManager? = ItemManager()
        
        let firstItem = ToDoItem(title: "First")
        itemManager?.addItem(item: firstItem)
        
        let secondItem = ToDoItem(title: "Second")
        itemManager?.addItem(item: secondItem)
        
        NotificationCenter.default.post(name: .UIApplicationWillResignActive, object: nil)
        
        itemManager = nil
        
        XCTAssertNil(itemManager)
        
        itemManager = ItemManager()
        XCTAssertEqual(itemManager?.toDoCount, 2)
        XCTAssertEqual(itemManager?.itemAtIndex(index: 0), firstItem)
        XCTAssertEqual(itemManager?.itemAtIndex(index: 1), secondItem)
    }
}
