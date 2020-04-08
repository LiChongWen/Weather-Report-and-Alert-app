//
//  MainViewController.swift
//  schoolProject
//
//  Created by Li arthur on 16/3/28.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import UIKit
import Instructions

class MainViewController: UIViewController, PopMenuDelegate{ //4
    // var page = UIView(frame: self.view.frame)
    
    
    
    
    
    var menuView: PopMenu!
    
    //var button: UIButton!
    
    
    @IBOutlet weak var button: UIButton!//5
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.button.center.y += 50
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let sign:Bool = NSUserDefaults.standardUserDefaults().boolForKey("FirstStartSign")
        if(!sign){
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstStartSign")
            print("第一次")
            self.coachMarksController.startOn(self)
        }
    }
    
    override func viewDidLoad() {
        
        self.coachMarksController.dataSource = self
        
        UIView.animateWithDuration(3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .AllowUserInteraction, animations: { 
            self.button.center.y -= 50
            }, completion: nil)

        
        //let image = UIImage(named: "button.png")
        //self.button.setImage(image, forState: UIControlState.Normal)
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backGround.jpg")!)
        //MARK:背景图片
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //创建PopMenu，并添加到view
        
        menuView = PopMenu(frame: self.view.frame)
        menuView.popDelegate = self // NO.5
        self.view.addSubview(menuView)
        
        
    }
    
    
    
    @IBAction func handleTap(sender: AnyObject) {
        //MARK:按钮出现特效
        let scale = CGAffineTransformMakeScale(0.5, 0.5)
        UIView.animateWithDuration(0.3) {
            self.button.transform = scale
        }
        
        let rotation = CGAffineTransformMakeRotation(CGFloat(2 * M_PI))

        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: {
            self.button.transform = rotation
            }, completion: nil)
        //MARK:调出菜单
        menuView.showMenuView()
    }
    
    //var sb = UIStoryboard(name: "Main", bundle: nil)
    
    
    func didClickMenu(index: Int) { //6
        print("click at \(index)")
        
        switch index{
        case 0 : performSegueWithIdentifier("text", sender: self)//self.presentViewController(tabBarVC, animated: true, completion: nil)
        case 1 : performSegueWithIdentifier("textChart", sender: self)
        case 2 : performSegueWithIdentifier("showMap", sender: self)
        case 3 : performSegueWithIdentifier("fwi", sender: self)
        case 4 : performSegueWithIdentifier("fwiChart", sender: self)
        case 5 : performSegueWithIdentifier("soilInfo", sender: self)
        default: break
        }
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "textChart"{
//            if let tct = segue.destinationViewController.contentController as? textChartViewController{
//                
//            }
//        }
//    }
//    
    
    @IBAction func unwind(unwindSegue: UIStoryboardSegue){
        
        print("I'm back")          // unwindSegue 用来返回
        
    }
    
    let coachMarksController = CoachMarksController()

    
}
extension UIViewController{
    var contentController: UIViewController{
        if let nav = self as? UINavigationController{
            return nav.visibleViewController!
        }else{
            return self
        }
    }
}

extension MainViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate{
    func numberOfCoachMarksForCoachMarksController(coachMarkController: CoachMarksController)
        -> Int {
            return 1
    }
    func coachMarksController(coachMarksController: CoachMarksController, coachMarksForIndex: Int)
        -> CoachMark {
            return coachMarksController.coachMarkForView(self.button)
    }
    func coachMarksController(coachMarksController: CoachMarksController, coachMarkViewsForIndex: Int, coachMark: CoachMark)
        -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
            let coachViews = coachMarksController.defaultCoachViewsWithArrow(true, arrowOrientation: coachMark.arrowOrientation)
            
            coachViews.bodyView.hintLabel.text = "点击这里试试看～!"
            coachViews.bodyView.nextLabel.text = "Ok!"
            
            return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
}

