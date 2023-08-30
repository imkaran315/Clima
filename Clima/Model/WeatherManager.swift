//
//  WeatherManager.swift
//  Clima
//
//  Created by Karan Verma on 25/08/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager{
    let url = "https://api.weatherapi.com/v1/current.json?key=5d0040892ac74f098bc131936232908"
    
    func fetchWeather(city: String){
        let urlString = "\(url)&q=\(city)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String){
 
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            
            task.resume()
        }
        
    }
    
    func handle( data: Data?, response: URLResponse? ,error: Error?){
        if error != nil{
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String( data: safeData, encoding: .utf8)
            print(dataString)

        }
    }
    
    
}
