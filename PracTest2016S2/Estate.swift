//
//  Estate.swift
//  PracTest2016S2
//
//  Created by KIM FOONG CHOW on 25/11/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit


class Estate: NSObject
{
    var name: String
    var population: Int
    var lat: Double
    var long: Double
    
    init(name: String, population: Int, lat: Double,long: Double) {
        self.name = name
        self.population = population
        self.lat = lat
        self.long = long
    }
}
