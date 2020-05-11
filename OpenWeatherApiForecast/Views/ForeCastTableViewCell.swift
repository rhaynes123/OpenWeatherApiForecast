//
//  ForeCastTableViewCell.swift
//  OpenWeatherApiForecast
//
//  Created by richard Haynes on 5/8/20.
//  Copyright © 2020 richqualitydevelopment. All rights reserved.
//

import UIKit

class ForeCastTableViewCell: UITableViewCell {

    @IBOutlet weak var DayLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func LoadForecast(forecastinfo: ForecastWeather){
        self.DayLabel.text = "\(forecastinfo.date)"
        self.TempLabel.text = "\(forecastinfo.temp)"
    }

}
