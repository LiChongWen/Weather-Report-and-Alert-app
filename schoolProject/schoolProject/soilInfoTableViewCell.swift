//
//  soilInfoTableViewCell.swift
//  schoolProject
//
//  Created by Li arthur on 16/4/23.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import UIKit
import FoldingCell

class soilInfoTableViewCell: FoldingCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberOfBase: UILabel!
    @IBOutlet weak var temOfSoilLabel: UILabel!
    @IBOutlet weak var humOfSoilLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var closedView: RotatedView!
    
    @IBOutlet weak var openedView: UIView!
    
    var soilInfo: SoilInfo?{
        didSet{
            updata()
        }
    }
    func updata(){
        numberLabel.text = soilInfo?.number
        numberOfBase.text = soilInfo?.numberOfBase
        temOfSoilLabel.text = soilInfo?.temOfSoil
        humOfSoilLabel.text = soilInfo?.humOfSoil
        timeLabel.text  = soilInfo?.time
        
        closedView.clipsToBounds = true
        closedView.layer.cornerRadius = CGFloat(6)
        openedView.clipsToBounds = true
        openedView.layer.cornerRadius = CGFloat(6)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }

}
