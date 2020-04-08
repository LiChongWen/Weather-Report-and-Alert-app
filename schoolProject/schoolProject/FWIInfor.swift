//
//  FWIInfor.swift
//  schoolProject
//
//  Created by Li arthur on 16/4/18.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import Foundation

public class FWIInfor: CustomStringConvertible{

    
    public var seven: String
    public var eight: String
    public var nine: String
    
    public var description: String{
        return "\(seven)\n\(eight)\n\(nine)"
    }
    
    init?(data: NSDictionary?){
        

        let seven = data?.valueForKey(Key.Seven) as? String
        let eight = data?.valueForKey(Key.Eight) as? String
        let nine = data?.valueForKey(Key.Nine) as? String
        if  seven != nil && eight != nil && nine != nil{

            self.seven = seven!
            self.eight = eight! + "级"
            self.nine = "FDate为   :" + nine!
        }else{

            self.seven = "7"
            self.eight = "8"
            self.nine = "9"
            return
        }
        
    }
    
    var asPropertyList: AnyObject {
        var dictionary = Dictionary<String,String>()

        dictionary[Key.Seven] = self.seven
        dictionary[Key.Eight] = self.eight
        dictionary[Key.Nine]  = self.nine
        return dictionary
    }
    
    struct Key {
        static let One = "one"
        static let Two = "two"
        static let Three = "three"
        static let Four = "four"
        static let Five = "five"
        static let Six = "six"
        static let Seven = "seven"
        static let Eight = "eight"
        static let Nine = "nine"
    }
}









