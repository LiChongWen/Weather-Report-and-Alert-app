//
//  CargoInfoDic.swift
//  weather
//
//  Created by Li arthur on 16/3/24.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import Foundation

class CargoInfoDic {
    var rawData: [String : String] = ["temp": ""]
    var cargoInfo:CargoInfo? {
        return CargoInfo(data: rawData)
    }
}
