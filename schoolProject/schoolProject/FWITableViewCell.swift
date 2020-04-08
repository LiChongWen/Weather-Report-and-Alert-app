//
//  FWITableViewCell.swift
//  schoolProject
//
//  Created by Li arthur on 16/4/19.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import UIKit
import FoldingCell

class FWITableViewCell: FoldingCell {

    @IBOutlet weak var fwiImage: UIImageView!
    
    @IBOutlet weak var openedImage: UIImageView!
    
    @IBOutlet weak var sevenLabel: UILabel!
    @IBOutlet weak var eightLabel: UILabel!
    @IBOutlet weak var nineLabel: UILabel!
    
    @IBOutlet weak var closeState: RotatedView!
    

    @IBOutlet weak var opened: UIView!
  
    
    var fwiInfo: FWIInfor?{
        didSet{
            updateUI()
        }
    }
    func updateUI(){
        let point = Double((fwiInfo?.seven)!)
        if point > 4{
            fwiImage.image = UIImage(named: "22")
            openedImage.image = UIImage(named: "红")
        }else{
            
            fwiImage.image = UIImage(named: "11")
            openedImage.image = UIImage(named: "绿")
        }
        

        closeState.clipsToBounds = true
        closeState.layer.cornerRadius = CGFloat(6)
        opened.clipsToBounds = true
        opened.layer.cornerRadius = CGFloat(6)
        
        
        sevenLabel.text = (fwiInfo?.seven)! + "度"
        eightLabel.text = fwiInfo?.eight
        nineLabel.text = fwiInfo?.nine
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
