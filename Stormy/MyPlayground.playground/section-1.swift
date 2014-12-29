// Playground - noun: a place where people can play

import UIKit


let apiKey = "459b10c1c58316fabe5154a4d819de2f"

let baseURL = NSURL(string:"https://api.forecast.io/forecast/\(apiKey)/")
let forecastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)

println("URL:\(forecastURL!)")

let weatherData = NSData(contentsOfURL: forecastURL!, options: nil, error: nil)

let string1 = NSString(data: weatherData!, encoding: NSUTF8StringEncoding)
println(string1!)

