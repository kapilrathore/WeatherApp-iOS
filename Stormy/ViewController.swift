//
//  ViewController.swift
//  Stormy
//
//  Created by Kapil Rathore on 15/08/15.
//  Copyright (c) 2015 Kapil Rathore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentHumidityLabel: UILabel?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentWeatherImage: UIImageView?
    @IBOutlet weak var currentWeatherSummary: UILabel?
    @IBOutlet weak var refreshButton: UIButton?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    private let forecasteAPIKey = "(Enter your API Key Here)"
    let coordinate: (lat: Double, long: Double) = (37.8267,-122.423)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        retrieveWeatherForecast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecasteAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long) {
            (let currently) in
            if let currentWeather = currently {
                //Upadte UI
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let temperature = currentWeather.temperature {
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    if let humidity = currentWeather.humidity {
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    if let precipitaion = currentWeather.precipProbability {
                        self.currentPrecipitationLabel?.text = "\(precipitaion)%"
                    }
                    if let icon = currentWeather.icon {
                        self.currentWeatherImage?.image = icon
                    }
                    if let summary = currentWeather.summary {
                        self.currentWeatherSummary?.text = "\(summary)"
                    }
                    self.toggleRefeshAnimation(false)
                }
            }
        }
    }
    
    @IBAction func refreshWeather() {
        toggleRefeshAnimation(true)
        retrieveWeatherForecast()
    }
    
    func toggleRefeshAnimation(on: Bool) {
        refreshButton?.hidden = on
        if on {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    }
    
}

