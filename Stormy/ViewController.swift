//
//  ViewController.swift
//  Stormy
//
//  Created by David Fontenot on 12/29/14.
//  Copyright (c) 2014 HackMatch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //access controls
    //3 access levels
    private let apiKey = "459b10c1c58316fabe5154a4d819de2f"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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

                
            }

        })
        downloadTask.resume()
//        let string1 = NSString(data: weatherData!, encoding: NSUTF8StringEncoding)
  //      println(string1!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

