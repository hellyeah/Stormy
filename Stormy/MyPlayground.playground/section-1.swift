// Playground - noun: a place where people can play

import UIKit


let apiKey = "459b10c1c58316fabe5154a4d819de2f"

let baseURL = NSURL(string:"https://api.forecast.io/forecast/\(apiKey)/")
let forecastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)

println("URL:\(forecastURL!)")

let weatherData = NSData(contentsOfURL: forecastURL!, options: nil, error: nil)

let string1 = NSString(data: weatherData!, encoding: NSUTF8StringEncoding)
println(string1!)

//STORYBOARD TRICKS
//Autosize element to fit text: CMD + =
//ctrl-drag to set autolayout
//at bottom, you have to update constraints
//duplicate element: option-drag or alt-drag

//can use assistant editor "preview" tab to display different screen sizes and orientations

//alt over space or other elements to show distance from selected element


//LOCATION DATA

import CoreLocation

var locationManager = CLLocationManager()
locationManager.desiredAccuracy = kCLLocationAccuracyBest
locationManager.requestAlwaysAuthorization()
locationManager.startUpdatingLocation()


var currentLocation = CLLocation()

if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
    CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
        
        currentLocation = locationManager.location
        println(currentLocation)
        
}
