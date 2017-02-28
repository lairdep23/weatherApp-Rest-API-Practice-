//
//  forecast.swift
//  FindMyWeather
//
//  Created by Evan on 2/25/17.
//  Copyright © 2017 Evan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Forecast {
    var _date: String!
    var _weather: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    var weather: String {
        if _weather == nil {
            _weather = ""
        }
        return _weather
    }
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let minTemp = temp["min"] as? Double {
                let Ktf = (minTemp * (9 / 5)) - 459.67
                let Ktf2 = Double(round(10 * Ktf/10))
                
                self._lowTemp = "\(Ktf2)"
            }
            
            if let maxTemp = temp["max"] as? Double {
                let Ktf = (maxTemp * (9 / 5)) - 459.67
                let Ktf2 = Double(round(10 * Ktf/10))
                
                self._highTemp = "\(Ktf2)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let weatherType = weather[0]["main"] as? String {
                self._weather = weatherType
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixDate = Date(timeIntervalSince1970: date)
            let dateformatter = DateFormatter()
            
            dateformatter.dateStyle = .full
            dateformatter.timeStyle = .none
            dateformatter.dateFormat = "EEE"
            self._date = unixDate.dayOfTheWeek()
        }
    }
}


extension Date {
    func dayOfTheWeek() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEE"
        return dateformatter.string(from: self)
    }
}














