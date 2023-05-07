import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var userInput: UITextField!
    
    var weatherApi = WeatherApi()
    var location = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location.requestWhenInUseAuthorization()
        location.requestLocation()
        
        weatherApi.delegate = self
        userInput.delegate = self
    }

    @IBAction func search(_ sender: UIButton) {
        weatherApi.fetchData(name: userInput.text!)
        userInput.endEditing(true)
    }
}

//Mark - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherApi.fetchData(name: userInput.text!)
        userInput.endEditing(true)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userInput.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if userInput.text == "" {
            userInput.placeholder = "Please Type Something"
            return false
        } else {
            return true
        }
    }
    
}

//Mark : WeatherApiData

extension WeatherViewController : weatherApiData {
    func weatherResult(weather: WeatherDataCollection) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.name
            self.temperatureLabel.text = String(format: "%.0f", weather.temp)
            self.conditionImageView.image = UIImage(systemName: weather.condition(weatherId: weather.id))
            
        }
    }
}

