//
//  currentWeather.swift
//  FindMyWeather
//
//  Created by Evan on 2/23/17.
//  Copyright © 2017 Evan. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weather: String!
    private var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .none
        let currentDate = dateformatter.string(from: Date())
        
        self._date = "\(currentDate)"
        
        return _date
    }
    var weather: String {
        if _weather == nil {
            _weather = ""
        }
        return _weather
        
    }
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        //AlamofireDownload
        
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    //print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String {
                        self._weather = main.capitalized
                        //print(self._weather)
                    }
                }
                
                if let mainWeather = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = mainWeather["temp"] as? Double {
                        let Ktf = (temp * (9/5) - 459.67)
                        let Ktf2 = Double(round(10 * Ktf/10))
                        self._currentTemp = Ktf2
                        //print(self._currentTemp)
                    }
                }
            }
            completed()
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
