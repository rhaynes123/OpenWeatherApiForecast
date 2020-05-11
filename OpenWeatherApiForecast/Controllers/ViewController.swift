//
//  ViewController.swift
//  OpenWeatherApiForecast
//
//  Created by richard Haynes on 5/7/20.
//  Copyright © 2020 richqualitydevelopment. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    // Mark outlets
    @IBOutlet weak var ForceCastTableView: UITableView!
    //Mark Vars
    var forecastWeather: ForecastWeather!
    var forecasts = [ForecastWeather]()
    var location = CLLocationManager()
    var currentcoordinates: CLLocation?
    var Longitude: Double!
    var Latitude: Double!
    var forecastApiURL: String = String()


    typealias  DownloadFinished = () -> ()
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
        GetLocation()
        GetDeledates()
       }
    
    func GetLocation(){
        location.delegate = self
        location.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if  !locations.isEmpty, currentcoordinates == nil {
            currentcoordinates = locations.first
            
            location.stopUpdatingLocation()
           GetForeCastWeather{
                print("Weather ForeCast Response: Completed")
            }
        }
    }
    
    func GetDeledates(){
        ForceCastTableView.delegate = self
        ForceCastTableView.dataSource = self
    }
    
    func GetForeCastWeather(completed: @escaping DownloadFinished){
        guard let currentcoordinates = currentcoordinates else{
                   return
               }
        Longitude = currentcoordinates.coordinate.longitude
        Latitude = currentcoordinates.coordinate.latitude
        forecastApiURL = "http://api.openweathermap.org/data/2.5/forecast?lat=\(Latitude ?? 0.0)&lon=\(Longitude ?? 0.0)&units=imperial&APPID=\(apiKey)"
        AF.request(forecastApiURL).responseJSON{ (response) in
            if let dictionary = response.value as? Dictionary<String, AnyObject>{
                if let list = dictionary["list"] as? [Dictionary<String, AnyObject>]{
                    for item in list {
                        let forecast = ForecastWeather(weatherDict: item)
                        self.forecasts.append(forecast)
                        
                    }
                    self.forecasts.remove(at: 0)
                    self.ForceCastTableView.reloadData()
                }
            }
            completed()
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherForecastcell = ForceCastTableView.dequeueReusableCell(withIdentifier: "ForeCast") as! ForeCastTableViewCell
        
        weatherForecastcell.LoadForecast(forecastinfo: forecasts[indexPath.row])
        return weatherForecastcell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
}

