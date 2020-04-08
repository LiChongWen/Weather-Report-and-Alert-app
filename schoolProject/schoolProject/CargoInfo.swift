//
//  CargoInfo.swift
//  weather
//
//  Created by Li arthur on 16/3/23.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import Foundation
public class CargoInfo : CustomStringConvertible{
    
   public var temp: String
   public var humidity: String
   public var rainfall: String
   public var fire: String
   public var time: String
    
    public var description: String{
        return "\(temp)\n\(humidity)\n\(rainfall)\n\(fire)\n\(time)"
    }
    
    init?(data: NSDictionary?){
        let temp = data?.valueForKey(Key.Temp) as? String
        let humidity = data?.valueForKey(Key.Humidity) as? String
        let rainfall = data?.valueForKey(Key.Rainfall) as? String
        let fire = data?.valueForKey(Key.Fire) as? String
        let time = data?.valueForKey(Key.Time) as? String
        if temp != nil &&  humidity != nil && rainfall != nil && fire != nil && time != nil{
            self.temp = temp! + "˚"
            self.humidity = humidity! + "˚"
            self.rainfall = "0" + rainfall! + "˚"
            self.fire =   "0" + fire! + "˚"
            self.time =   time!
        }else{
            self.temp = "1"
            self.time = "2"
            self.humidity = "3"
            self.fire = "4"
            self.rainfall = "5"
            return 
        }
        
    }
    
//    var asPropertyList: AnyObject {
//        var dictionary = Dictionary<String,String>()
//        dictionary[Key.Temp] = self.temp
//        dictionary[Key.Humidity] = self.humidity
//        dictionary[Key.Rainfall] = self.rainfall
//        dictionary[Key.Fire] = self.fire
//        dictionary[Key.Time] = self.time
//        return dictionary
//    }
    
    struct Key {
        static let Temp = "temp"
        static let Humidity = "humidity"
        static let Rainfall = "rainfall"
        static let Fire = "fire"
        static let Time = "time"
    }
    
}


