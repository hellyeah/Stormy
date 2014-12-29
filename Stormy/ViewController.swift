//
//  ViewController.swift
//  Stormy
//
//  Created by David Fontenot on 12/29/14.
//  Copyright (c) 2014 HackMatch. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var precipitationLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    
    @IBOutlet var refreshButton: UIButton!
    
    @IBOutlet var refreshActivityIndicator: UIActivityIndicatorView!
    
    //access controls
    //3 access levels
    private let apiKey = "459b10c1c58316fabe5154a4d819de2f"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshActivityIndicator.hidden = true
        
//        let string1 = NSString(data: weatherData!, encoding: NSUTF8StringEncoding)
  //      println(string1!)
        getCurrentWeatherData()
        //println(getLocation().latitude)
        
    }
    
    func getCurrentWeatherData () -> Void {
        let baseURL = NSURL(string:"https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)
        //println("URL:\(forecastURL!)")
        
        //        let weatherData = NSData(contentsOfURL: forecastURL!, options: nil, error: nil)
        //        println(weatherData)
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            //            var urlContents = NSString(contentsOfURL: location, encoding: NSUTF8StringEncoding, error: nil)
            //            println(urlContents)
            
            if(error == nil) {
                //swift dictionaries can only store 1 type, so we use NSDictionary
                let dataObject = NSData(contentsOfURL: location)
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
                
                let currentWeather = Current(weatherDictionary: weatherDictionary)
                println(currentWeather.currentTime!)
                
                //NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil)
                //println(weatherDictionary)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.temperatureLabel.text = "\(currentWeather.temperature)"
                    self.iconView.image = currentWeather.icon!
                    self.currentTimeLabel.text = "At \(currentWeather.currentTime!) it is"
                    self.humidityLabel.text = "\(currentWeather.humidity)"
                    self.precipitationLabel.text = "\(currentWeather.precipProbability)"
                    self.summaryLabel.text = "\(currentWeather.summary)"
                    
                    //one of the intended effects of hiding a button is that the user can't interact with it
                    //stop refresh animation
                    self.refreshActivityIndicator.stopAnimating()
                    self.refreshActivityIndicator.hidden = true
                    self.refreshButton.hidden = false
                })
            } else {
                let networkIssueController  = UIAlertController(title: "Error", message: "Unable to load data. Connectivity Error!", preferredStyle: .Alert)
                
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                networkIssueController.addAction(okButton)
                
                let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                networkIssueController.addAction(cancelButton)
                
                self.presentViewController(networkIssueController, animated: true, completion: nil)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //stop refresh animation
                    self.refreshActivityIndicator.stopAnimating()
                    self.refreshActivityIndicator.hidden = true
                    self.refreshButton.hidden = false
                })

            }
            
        })
        downloadTask.resume()
    }
    
    func getLocation () -> (latitude: String, longitude: String)? {
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        var currentLocation = CLLocation()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
                
                currentLocation = locationManager.location
                return ("\(currentLocation.coordinate.latitude)", "\(currentLocation.coordinate.longitude)")
                
        } else {
            return nil
        }
    }


    @IBAction func refresh() {
        getCurrentWeatherData()
        
        refreshButton.hidden = true
        refreshActivityIndicator.hidden = false
        refreshActivityIndicator.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

