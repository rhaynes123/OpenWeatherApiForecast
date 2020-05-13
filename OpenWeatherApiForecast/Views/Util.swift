//
//  Util.swift
//  OpenWeatherApiForecast
//
//  Created by richard Haynes on 5/7/20.
//  Copyright © 2020 richqualitydevelopment. All rights reserved.
//

import Foundation
let apiKey = "11d190b14006127cf0e41d6868e79aff"

typealias  DownloadFinished = () -> ()
class Utils{
    func ReFormatDate(date: Date) ->String{
        var reformattedDate: String?
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .full

        dateFormatter.timeStyle = .full

        reformattedDate = dateFormatter.string(from: date)
        
        return reformattedDate! //
    }

}

