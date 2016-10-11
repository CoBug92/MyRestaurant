//
//  Restaurant.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 07/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import Foundation

class Restaurant {
    var name: String                //The variable responsible for name of restaurant
    var type: String                //The variable responsible for type of restaurant
    var image: String               //The variable responsible for image of restaurant
    var location: String            //The variable responsible for location of restaurant
    var wasVisited: Bool = false    //The variable responsible for visit
    
    //Create Restaurant object
    init(name: String, type: String, image: String, location: String, wasVisited: Bool) {
        self.name = name
        self.type = type
        self.image = image
        self.location = location
        self.wasVisited = wasVisited
    }
}
