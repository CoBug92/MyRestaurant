//
//  Restaurant.swift
//  MyRestraunts
//
//  Created by Богдан Костюченко on 07/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import Foundation

class Restaurant {
    var name: String
    var type: String
    var image: String
    var location: String
    var wasVisited: Bool = false
    
    init(name: String, type: String, image: String, location: String, wasVisited: Bool) {
        //как будет создаваться наш класс
        self.name = name
        self.type = type
        self.image = image
        self.location = location
        self.wasVisited = wasVisited
    }
}
