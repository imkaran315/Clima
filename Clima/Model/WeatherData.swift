//
//  WeatherData.swift
//  Clima
//
//  Created by Karan Verma on 31/08/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct WeatherData : Decodable{
    let name: String
    let main: Main
    let coord: Coord
    let weather: [Weather]
    
}
struct Weather: Decodable{
    let id: Int
}

struct Main: Decodable{
    let temp: Double
}
struct Coord: Decodable{
    let lat: Double
    let lon: Double
}

