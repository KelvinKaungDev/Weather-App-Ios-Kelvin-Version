//
//  WeatherDataCollection.swift
//  Clima
//
//  Created by Kaung Htet OO on 5/7/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

struct WeatherDataCollection {
    var name : String
    var temp : Double
    var id : Int
    
    func condition(weatherId : Int) -> String {
        switch weatherId {
            case 200...250 :
                return "cloud.bolt"
            case 300...350 :
                return "cloud.rain"
            case 600...630 :
                return "snowflake"
            case 700...782 :
                return "tornado"
            case 800 :
                return "sun.and.horizon"
            case 801...820 :
                return "cloud.sun"
            default :
                return "error"
        }
    }
}
