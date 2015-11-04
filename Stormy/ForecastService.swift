//
//  ForecastService.swift
//  Stormy
//
//  Created by Kapil Rathore on 03/11/15.
//  Copyright © 2015 Kapil Rathore. All rights reserved.
//

import Foundation

struct ForecastService {
    
    let forecasteAPIKey: String
    let forecasteBaseURL: NSURL?
    
    init(APIKey: String) {
        forecasteAPIKey = APIKey
        forecasteBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecasteAPIKey)/")
    }
    
    func getForecast(lat: Double, long: Double, completion: (CurrentWeather? -> Void)) {
        if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecasteBaseURL) {
            
            let networkOperation = NetworkOperation(url: forecastURL)
            
            networkOperation.downloadJSONFromURL {
                (let JSONDictionary) in
                let currentWeather = self.currentWeatherFromJSON(JSONDictionary)
                completion(currentWeather)
            }
            
        } else {
            print("Could not construct a valid URL")
        }
    }
    
    func currentWeatherFromJSON(jsonDictionary: [String: AnyObject]?) -> CurrentWeather? {
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject] {
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        } else {
            print("JSON dictionary retured nil for 'currently' key")
            return nil
        }
    }
}
