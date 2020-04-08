//
//  infoTableViewCell.swift
//  weather
//
//  Created by Li arthur on 16/3/23.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import UIKit
import FoldingCell

class infoTableViewCell: FoldingCell {

    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    var cargoInfo: CargoInfo?{
        didSet{
            
            
            updateUI()
            
        }
    }

    func updateUI(){
        
          
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)  //UIColor(red: 137/255, green: 210/255, blue: 228/255, alpha: 1)
//UIColor(patternImage: UIImage(named: "backGround.jpg")!)
        
        
        temp.text = cargoInfo?.temp
        temp.textColor = UIColor.whiteColor()
        humidity.text = cargoInfo?.humidity
        humidity.textColor = UIColor.whiteColor()
        rainfall.text = cargoInfo?.rainfall
        rainfall.textColor = UIColor.whiteColor()
        fire.text = cargoInfo?.fire
        fire.textColor = UIColor.whiteColor()
        time.text = cargoInfo?.time
      
        //closed.backgroundColor = UIColor(red: 61/255, green: 77/255, blue: 100/255, alpha: 0.7)
        closed.clipsToBounds = true
        closed.layer.cornerRadius = 6
        //opened.backgroundColor = UIColor(red: 61/255, green: 77/255, blue: 100/255, alpha: 0.7)
        opened.clipsToBounds = true
        opened.layer.cornerRadius = 6
        
    }
    
    @IBOutlet weak var closed: RotatedView!
    @IBOutlet weak var opened: UIView!
    
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var rainfall: UILabel!
    @IBOutlet weak var fire: UILabel!
    @IBOutlet weak var time: UILabel!


}
