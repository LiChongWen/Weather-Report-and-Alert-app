//
//  caRequest.swift
//  weather
//
//  Created by Li arthur on 16/3/23.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

class caRequest {
    func get(number: Int) //-> String
    {
        print("1")
        
        let url = NSURL(string: "http://120.25.241.214:8080/Service1.asmx/selectAllCargoInfor")
       
        
         Alamofire.request(.POST, url!).responseString(encoding: NSUTF8StringEncoding){
            response in
            let responseString = response.result.value!
            //print(responseString)
            let xmlWithNameSpace = responseString
            
            let xml = SWXMLHash.parse(xmlWithNameSpace)
            let a: String = (xml["ArrayOfString"]["string"][number].element?.text!)!
            
        }
        //return self.result(a)
    }
//    func result(realnumber: String) -> String{
//        return realnumber
//    }
}