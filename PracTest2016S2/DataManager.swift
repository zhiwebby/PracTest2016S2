//
//  DataManager.swift
//  PracTest2016S2
//
//  Created by KIM FOONG CHOW on 25/11/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit
import Firebase

class DataManager: NSObject
{
    
    static func loadEstates(onComplete : @escaping ([Estate]) -> Void)
    {
        // create an empty list.
        var estateList : [Estate] = []
        
        //.child("/") means we are looking at the root element
        //
        let ref = FIRDatabase.database().reference().child("/")
        
        // observeSingleEventOfType tells Firebase
        // to load the full list of Movies, and execute the
        // "with" closure once, when the download
        // is complete.
        //
        ref.observeSingleEvent(of: .value,
                               with:
            { (snapshot) in
                // This is the "with" closure that
                // executes only when the retrieval
                // of data from Firebase is complete.
                // Meanwhile, before the download is complete,
                // the user can still interact with the user
                // interface.
                //
                for record in snapshot.children {
                    let r = record as! FIRDataSnapshot
                    
                    print (r.key)
                    
                    estateList.append(Estate(
                                           name: r.childSnapshot(forPath: "name").value                                             as! String,
                                           population: r.childSnapshot(forPath:
                                            "pop").value as! Int,
                                           lat: r.childSnapshot(forPath:
                                                "latitude").value as! Double,
                                             long: r.childSnapshot(forPath:
                                                "longitude").value as! Double)
                    )
                    
                }
                // Once the list of movies have been downloaded,
                // call a function (a closure) passed in through
                // the onComplete parameter. This allows the caller
                // to do any further processing or update the UI.
                //
                onComplete(estateList)
        })
    }
    
}

