//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchbar: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    @IBAction func locationPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        searchbar.delegate = self
        
    }
}


// MARK: - UITextFieldDelegate Section
extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func searchButton(_ sender: UIButton) {
        searchbar.endEditing(true)
        print(searchbar.text!)
    }
    
    
    
    // triggers when pressed "return" key in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchbar.endEditing(true)
        print(searchbar.text!)
        return true
    }
    
    // checks for condition before triggering textfieldendEditiong func
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }
        else{
            textField.placeholder = "Type city name"
            return false
        }
    }
    
    // triggered when editing text is stopped
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let cityName = searchbar.text{
            weatherManager.fetchWeather(city: cityName)
        }
        textField.text = ""
        textField.placeholder = "search"
    }
}



// MARK: - WeatherManagerDelegate Section
extension WeatherViewController: WeatherManagerDelegate{
    
    
    func didUpdateWeather(weather : WeatherModel){
        
        DispatchQueue.main.async{
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        print(weather.cityName, weather.temperatureString)
        
    }
}

// MARK: - LocationManagerDelegate Section
extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation() // stops the location update, so we can use it next time as well
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat, longitude: lon) 
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
