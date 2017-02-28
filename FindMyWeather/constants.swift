//
//  constants.swift
//  FindMyWeather
//
//  Created by Evan on 2/23/17.
//  Copyright © 2017 Evan. All rights reserved.
//

import Foundation

let base_url = "http://api.openweathermap.org/data/2.5/weather?"
let api_key = "lat=\(Location.sharedInstance.lat!)&lon=\(Location.sharedInstance.long!)&appid=06ccf07aca750f8d25543fcb97135d9f"

let base_url_forecast = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let api_key_forecast = "lat=\(Location.sharedInstance.lat!)&lon=\(Location.sharedInstance.long!)&cnt=10&appid=06ccf07aca750f8d25543fcb97135d9f"

let forecast_url = "\(base_url_forecast)\(api_key_forecast)"

let currentWeatherURL = "\(base_url)\(api_key)"

typealias DownloadComplete = () -> ()
