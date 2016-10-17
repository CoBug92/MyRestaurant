//
//  Restaurant.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 07/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import Foundation
import CoreData

class Restaurant: NSManagedObject {
    @NSManaged var name: String!     //The variable responsible for name of restaurant
    @NSManaged var type: String!     //The variable responsible for type of restaurant
    @NSManaged var location: String! //The variable responsible for location of restaurant
    @NSManaged var image: NSData!     //The variable responsible for type of restaurant
    @NSManaged var wasVisited: NSNumber! //The variable responsible for location of restaurant
    

    //Create Restaurant object
//    init(name: String, type: String, image: String, location: String, wasVisited: Bool) {
//        self.name = name
//        self.type = type
//        self.image = image
//        self.location = location
//        self.wasVisited = wasVisited
//    }
}
