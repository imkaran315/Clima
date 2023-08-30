//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchbar: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        searchbar.delegate = self
    }

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

