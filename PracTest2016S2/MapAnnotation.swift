//
//  MapAnnotation.swift
//  PracTest2016S2
//
//  Created by KIM FOONG CHOW on 26/11/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit
import MapKit
class MapAnnotation: NSObject, MKAnnotation
{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D,
        title: String,
        subtitle: String)
    {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
}
