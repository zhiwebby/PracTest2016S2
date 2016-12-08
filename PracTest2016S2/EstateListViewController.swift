//
//  FirstViewController.swift
//  PracTest2016S2
//
//  Created by KIM FOONG CHOW on 24/11/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit
import CoreLocation

class EstateListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate
{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var distanceLabel : UILabel!
    
    var estatesList : [Estate] = []
    
    
    //MARK: Location
    var locationManager : CLLocationManager?
    
    var lastLocationUpdateTime : Date = Date()
    var userLocation: CLLocation?
    
    // This function receives information about the change of the
    // user’s GPS location. The locations array may contain one
    // or more location updates that were collected in-between calls
    // to this function.
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        // There are multiple locations, but we are only
        // interested in the last one.
        userLocation = locations.last!;
        // Get find out how old (in seconds) this data was.
        let howRecent =
            self.lastLocationUpdateTime.timeIntervalSinceNow;
        // Handle only recent events to save power.
        if (abs(howRecent) > 15)
        {
            print("Longitude = \(userLocation?.coordinate.longitude)");
            print("Latitude = \(userLocation?.coordinate.latitude)");
            self.lastLocationUpdateTime = Date()
        }
    }
    
    // This function is triggered if the location manager was unable
    // to retrieve a location.
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Could not find location: \(error)");
        distanceLabel.text = "???"
    }
    
    //MARK: VIEW CONTROLLER METHODS
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // This is a special way to call loadMovies.
        //
        // Even if loadMovies accepts a closure as a
        // parameter, I can pass that parameter after
        // the round brackets. In a way it is // easier to read.
        //
        DataManager.loadEstates ()
            {
                estateListFromFirebase in
                
                // This is a closure.
                //
                // This block of codes is executed when the
                // async loading from Firebase is complete.
                // What it is to reassigned the new list loaded
                // from Firebase.
                //
                self.estatesList = estateListFromFirebase
                
                // Once done, call on the Table View to reload
                // all its contents
                //
                self.tableView.reloadData()
        }
        
        //Create Location manager object
        locationManager = CLLocationManager();
        //Set the delegate property of the location manager to self
        locationManager?.delegate = self;
        
        //Set the most accurate location data as possible
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
        // Check for iOS 8. Without this guard the code will
        // crash with "unknown selector" on iOS 7.
        let ios8 = locationManager?.responds(to:
            #selector(CLLocationManager.requestWhenInUseAuthorization))
        if (ios8!) {
            locationManager?.requestWhenInUseAuthorization();
        }
        
        //Tell the location manager to start looking for its location
        //immediately
        locationManager?.startUpdatingLocation();
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: TABLE VIEW METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return estatesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! EstateTableViewCell
        let e = estatesList[(indexPath as IndexPath).row]
        cell.nameLabel?.text = e.name
        cell.populationLabel?.text = "Population: \(e.population)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if userLocation != nil
        {
            var estateSelected = estatesList[indexPath.row]
            
            var dist = userLocation!.distance(from: CLLocation(latitude: estateSelected.lat, longitude: estateSelected.long)
            )
            
            distanceLabel.text = String(format: "%0.1f",
            dist / 1000) + " km"
        }
        else
        {
            distanceLabel.text = "??? km"
        }
    }
    
  



}

