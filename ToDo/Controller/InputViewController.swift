//
//  InputViewController.swift
//  ToDo
//
//  Created by Emmanuel Francisco Tugado on 19/1/17.
//  Copyright © 2017 Emmanuel Tugado. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    @IBAction func save() {
        print(#function)
        guard let titleString = titleTextField.text, titleString.characters.count > 0 else { return }
        
        let date: Date?
        if let dateText = self.dateTextField.text, dateText.characters.count > 0 {
            date = dateFormatter.date(from: dateText)
        } else {
            date = nil
        }
        
        let descriptionString = descriptionTextField.text
        
        if let locationName = locationTextField.text, locationName.characters.count > 0 {
            if let address = addressTextField.text, address.characters.count > 0 {
                print("setting the variable completionhandler of mockgeocoder")
                geocoder.geocodeAddressString(address) { [unowned self] (placemarks, error) -> Void in
                    let placemark = placemarks?.first
                    
                    let item = ToDoItem(title: titleString, description: descriptionString, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName, coordinate: placemark?.location?.coordinate))
                    
                    self.itemManager?.addItem(item: item)
                }
            }
        } else {
            let item = ToDoItem(title: titleString,
                                description: descriptionString,
                                timestamp: date?.timeIntervalSince1970,
                                location: nil)
            self.itemManager?.addItem(item: item)
        }
    
        dismiss(animated: true, completion: nil)
    }
}
