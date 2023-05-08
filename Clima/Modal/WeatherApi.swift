import Foundation

protocol weatherApiData {
    func weatherResult(weather : WeatherDataCollection)
}

struct WeatherApi {
    
    var delegate : weatherApiData?
    
    func fetchData(name : String) {
        var key = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=b6af36398d3c9dd99142e3078377c053&units=metric"
        getData(key: key)
    }
    
    func fetchData(lat : Double, lon : Double) {
        var key = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=b6af36398d3c9dd99142e3078377c053&units=metric"
        getData(key: key)
    }
    
    func getData(key : String) {
        if let url = URL(string: key) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let data =  self.praseData(data: safeData)!
                    let result = WeatherDataCollection(name: data.name, temp: data.main.temp, id: data.weather[0].id)
                    
                    delegate?.weatherResult(weather: result)
                }
            }
            task.resume()
        }
    }
    
    func praseData(data : Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(WeatherData.self, from: data)
            return data
        } catch {
            print(error)
            return nil
        }
    }
}
