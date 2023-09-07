//
//  WeatherManager.swift
//  Clima
//
//  Created by Karan Verma on 25/08/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather (weather: WeatherModel)
}

struct WeatherManager{
    let url = "https://api.openweathermap.org/data/2.5/weather?id=524901&appid=8630a0fe8840a24fe98bbed84c49b3e6"
    
    var delegate  : WeatherManagerDelegate?
    
    func fetchWeather(city: String){
        let urlString = "\(url)&q=\(city)"
         performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude :CLLocationDegrees , longitude: CLLocationDegrees ){
        
        let string = "\(url)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: string)
    }
    
    func performRequest(urlString : String){
        
        
             // 1. create URL
        if let url = URL(string: urlString){
            
            // 2. create url session
            let session = URLSession(configuration: .default)
            
            // 3. give session a task
            let task = session.dataTask(with: url, completionHandler: { ( data: Data?, response: URLResponse? ,error: Error?) in
                if error != nil{
                    print("task did not happened")
                    return 
                }
                
                if let safeData = data {
                   if let weather = self.parseJSON(weatherData : safeData)
                    {
                       self.delegate?.didUpdateWeather(weather: weather)
                        
                    }

                }
            })
            // 4. resume the task
            task.resume()
            }
      }
    
     func parseJSON(weatherData : Data) -> WeatherModel?{
       let decoder = JSONDecoder()
        
       do {
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
           let id = decodedData.weather[0].id
           let temp = decodedData.main.temp
           let name = decodedData.name
           
           let weather = WeatherModel(conditionId: id, temperature: temp, cityName: name)
           
           return weather
           
        }catch {
            print("decodedData didn't work")
            return nil
        }
        
    }
    
    
    
}
