//
//  FWIInforDic.swift
//  schoolProject
//
//  Created by Li arthur on 16/4/18.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import Foundation

class FWIInforDic {
    
    var rawData: [String : String] = ["one" : ""]
    
    var fwiInfo: FWIInfor?{
        return FWIInfor(data: rawData)
    }
    
}