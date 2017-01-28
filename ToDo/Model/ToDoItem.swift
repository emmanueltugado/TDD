//
//  ToDoItem.swift
//  ToDo
//
//  Created by Emmanuel Francisco Tugado on 14/1/17.
//  Copyright © 2017 Emmanuel Tugado. All rights reserved.
//

import Foundation

struct ToDoItem: Equatable {
    private let titleKey = "titleKey"
    private let descriptionKey = "descriptionKey"
    private let timestampKey = "timestampKey"
    private let locationKey = "locationKey"
    
    var plistDict: [String: Any] {
        var dict: [String: Any] = [:]
        dict[titleKey] = title
        
        if let description = description {
            dict[descriptionKey] = description
        }
        if let timestamp = timestamp {
            dict[timestampKey] = timestamp
        }
        
        if let location = location {
            let locationDict = location.plistDict
            dict[locationKey] = locationDict
        }
        
        return dict
    }
    
    let title: String
    let description: String?
    let timestamp: Double?
    let location: Location?
    
    init(title: String, description: String? = nil, timestamp: Double? = nil, location: Location? = nil) {
        self.title = title
        self.description = description
        self.timestamp = timestamp
        self.location = location
    }
    
    init?(dict: [String: Any]) {
        guard let title = dict[titleKey] as?  String else{
            return nil
        }
        
        self.title = title
        
        self.description = dict[descriptionKey] as?  String
        self.timestamp = dict[timestampKey] as?  Double
        
        if let locationDict = dict[locationKey] as?  [String:Any] {
            self.location = Location(dict: locationDict)
        } else {
            self.location = nil
        }
    }
}

func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
    if lhs.location != rhs.location {
        return false
    }
    if lhs.timestamp != rhs.timestamp {
        return false
    }
    if lhs.description != rhs.description {
        return false
    }
    if lhs.title != rhs.title {
        return false
    }
    
    return true
}
