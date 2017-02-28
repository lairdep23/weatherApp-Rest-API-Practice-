//
//  WeatherCell.swift
//  FindMyWeather
//
//  Created by Evan on 2/25/17.
//  Copyright © 2017 Evan. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var highTemp: UILabel!
    
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast: Forecast) {
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        dayLabel.text = forecast.date
        weatherLabel.text = forecast.weather
        
        if forecast.weather == "Rain" {
            weatherIcon.image = UIImage(named: "Rainy")
        } else if forecast.weather == "Clouds" {
            weatherIcon.image = UIImage(named: "Cloudy")
        } else {
            weatherIcon.image = UIImage(named: forecast.weather)
        }
        
    }

}
