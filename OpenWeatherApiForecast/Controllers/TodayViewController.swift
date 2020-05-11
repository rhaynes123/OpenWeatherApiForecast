//
//  TodayViewController.swift
//  OpenWeatherApiForecast
//
//  Created by richard Haynes on 5/9/20.
//  Copyright © 2020 richqualitydevelopment. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
class TodayViewController: UIViewController,CLLocationManagerDelegate {
    // Mark outlets
    @IBOutlet weak var WeatherLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    //Mark Vars
    public var WeatherDescription: String!
    public var Temperature: Double!
    public var City: String!
    let util = Utils()
    var apiURL : String = String()
    var location = CLLocationManager()
    var currentcoordinates: CLLocation?
    var forecastWeather: ForecastWeather!
    var Longitude: Double!
    var Latitude: Double!
    
    typealias  DownloadFinished = () -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetLocation()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     GetLocation()
    
     self.GetCurrentWeatherApiResponse {
         self.LoadCurrentWeatherData()
         print("Todays Weather Response: Completed")
         
     }
    }
    func GetLocation(){
        location.delegate = self
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if  !locations.isEmpty, currentcoordinates == nil {
            currentcoordinates = locations.first
            location.stopUpdatingLocation()
            self.GetCurrentWeatherApiResponse {
                self.LoadCurrentWeatherData()
                print("Todays Weather Response: Completed")
                
            }
           
        }
    }
    func LoadCurrentWeatherData(){
    
        CityLabel.text = City
        TempLabel.text = "\(Temperature ?? 0)"
        WeatherLabel.text = WeatherDescription
        DateLabel.text = "\(util.ReFormatDate(date: Date()))"
        
     }
    
    func GetCurrentWeatherApiResponse(completed: @escaping DownloadFinished ){
        guard let currentcoordinates = currentcoordinates else{
                       return
                   }
        Longitude = currentcoordinates.coordinate.longitude
        Latitude = currentcoordinates.coordinate.latitude
        apiURL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Latitude ?? 0.0)&lon=\(Longitude ?? 0.0)&units=imperial&APPID=\(apiKey)"
        AF.request(apiURL).responseJSON { (response) in
                
               let json = JSON(response.value!)
               self.City = json["name"].stringValue
               self.WeatherDescription = json["weather"][0]["main"].stringValue
               self.Temperature = json["main"]["temp"].double
               completed()
           }
          
       }

}
