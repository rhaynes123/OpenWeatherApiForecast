//
//  ForecastWeather.swift
//  OpenWeatherApiForecast
//
//  Created by richard Haynes on 5/8/20.
//  Copyright © 2020 richqualitydevelopment. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import CoreLocation
class ForecastWeather {
    let apiKey = "11d190b14006127cf0e41d6868e79aff"
    private var ForeCastDateTime: String!
    private var ForeCastTemp: Double!
    var forecasts = [ForecastWeather]()
    var forecastTable = ViewController()
    var util = Utils()
    
    var date: String {
        if ForeCastDateTime == nil {
            ForeCastDateTime = ""
        }
        return ForeCastDateTime
    }
    
    
    var temp: Double {
        if ForeCastTemp == nil {
            ForeCastTemp = 0.0
        }
        return ForeCastTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let main = weatherDict["main"] as? Dictionary<String, AnyObject> {
            if let temp = main["temp"] as? Double {
                self.ForeCastTemp = temp
               
            }
            
        }
        
        if let date = weatherDict["dt"] as? Double{
            let unixtimestamp = Date(timeIntervalSince1970: date)
            print(unixtimestamp)
            self.ForeCastDateTime = "\(util.ReFormatDate(date: unixtimestamp))"
            print(ForeCastDateTime ?? "")
        }
    }
}
