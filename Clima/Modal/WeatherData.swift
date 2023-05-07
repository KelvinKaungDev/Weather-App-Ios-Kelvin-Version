import Foundation

struct WeatherData : Codable {
    var name : String
    var main : Main
    var weather : [Weather]
}

struct Weather : Codable {
    var id : Int
    var description : String
}

struct Main : Codable {
    var temp : Double
}


