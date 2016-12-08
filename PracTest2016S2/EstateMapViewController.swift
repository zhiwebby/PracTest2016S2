//
//  SecondViewController.swift
//  PracTest2016S2
//
//  Created by KIM FOONG CHOW on 24/11/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class EstateMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView : MKMapView!
    
    var estatesList : [Estate] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //MARK: LOCATION
        DataManager.loadEstates ()
        {
                estateListFromFirebase in
                
                for estate in estateListFromFirebase
                {
                    let coord = CLLocationCoordinate2D(latitude: estate.lat, longitude: estate.long)
                    
                    let dropPin = MapAnnotation(coordinate: coord, title: estate.name, subtitle: "Population: \(estate.population)")
                    
                    self.mapView.addAnnotation(dropPin)
                }
                for pin in self.mapView.annotations
                {
                    let annotation = pin as! MapAnnotation
                    
                    print(annotation.title!)
                    print(annotation.subtitle!)
                    
                }
                
        }


    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

