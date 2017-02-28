//
//  location.swift
//  FindMyWeather
//
//  Created by Evan on 2/26/17.
//  Copyright © 2017 Evan. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {
        
    }
    var lat: Double!
    var long: Double!
    
    
}
