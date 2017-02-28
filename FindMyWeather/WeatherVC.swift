//
//  ViewController.swift
//  FindMyWeather
//
//  Created by Evan on 2/23/17.
//  Copyright © 2017 Evan. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    
    var currentWeather = CurrentWeather()
    var forecasts = [Forecast]()
    var forecast: Forecast!
    let locationManager = CLLocationManager()
    var currentLoc: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    func locationStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLoc = locationManager.location
            Location.sharedInstance.lat = currentLoc.coordinate.latitude
            Location.sharedInstance.long = currentLoc.coordinate.longitude
            print(Location.sharedInstance.long)
            print(Location.sharedInstance.lat)
            currentWeather.downloadWeatherDetails {
                print(forecast_url)
                print(currentWeatherURL)
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationStatus()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationStatus()
    }
    
    func downloadForecastData(completed: DownloadComplete){
        
        Alamofire.request(forecast_url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    
                    self.forecasts.remove(at: 0)
                    self.weatherTableView.reloadData()
                }
            }
        }
        
        completed()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = String(currentWeather.currentTemp)
        print(currentTempLabel.text ?? "poop")
        locationLabel.text = currentWeather.cityName
        currentWeatherLabel.text = currentWeather.weather
        currentImage.image = UIImage(named: currentWeather.weather)
        
        if currentWeather.weather == "Rain" {
            currentImage.image = UIImage(named: "Rainy")
        } else if currentWeather.weather == "Clouds" {
            currentImage.image = UIImage(named: "Cloudy")
        } else {
            currentImage.image = UIImage(named: currentWeather.weather)
        }
    }

    


}

