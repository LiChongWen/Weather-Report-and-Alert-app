//
//  SoilInfo.swift
//  schoolProject
//
//  Created by Li arthur on 16/4/23.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import Foundation

public class SoilInfo: CustomStringConvertible {
    public var number: String
    public var numberOfBase: String
    public var temOfSoil: String
    public var humOfSoil: String
    public var time: String
    
    
    public var description: String{
        return "\(number)\n\(numberOfBase)\n\(temOfSoil)\n\(humOfSoil)\n\(time)\n"
    }
    
    init?(data: NSDictionary?){
        let number = data?.valueForKey(Key.Number) as? String
        let numberOfBase = data?.valueForKey(Key.NumberOfBase) as? String
        let temOfSoil = data?.valueForKey(Key.TemOfSoil) as? String
        let humOfSoil = data?.valueForKey(Key.HumOfSoil) as? String
        let time = data?.valueForKey(Key.Time) as? String
        if number != nil && numberOfBase != nil && temOfSoil != nil && humOfSoil != nil && time != nil{
            self.number = number!
            self.numberOfBase = numberOfBase!
            self.temOfSoil = temOfSoil!
            self.humOfSoil = humOfSoil!
            self.time =  time!
        }else{
            self.number = "1"
            self.numberOfBase = "1"
            self.temOfSoil = "1"
            self.humOfSoil = "1"
            self.time = "1"
            return
        }
    }
    
    var asPropertyList: AnyObject {
        var dictionary = Dictionary<String,String>()
        dictionary[Key.Number] = self.number
        dictionary[Key.NumberOfBase] = self.numberOfBase
        dictionary[Key.TemOfSoil] = self.temOfSoil
        dictionary[Key.HumOfSoil] = self.humOfSoil
        dictionary[Key.Time] = self.time
    
        return dictionary
    }
    
    struct Key {
        static let Number = "number"
        static let NumberOfBase = "numberOfBase"
        static let TemOfSoil = "temOfSoil"
        static let HumOfSoil = "humOfSoil"
        static let Time = "time"
        
    }
}