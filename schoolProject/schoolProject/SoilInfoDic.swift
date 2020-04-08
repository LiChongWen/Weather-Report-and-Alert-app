//
//  SoilInfoDic.swift
//  schoolProject
//
//  Created by Li arthur on 16/4/23.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import Foundation

class SoilInfoDic {
    var rawData: [String : String] = ["number" : " "]
    var soilInfo: SoilInfo?{
        return SoilInfo(data: rawData)
    }
}