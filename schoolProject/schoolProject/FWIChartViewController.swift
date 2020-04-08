//
//  FWIChartViewController.swift
//  schoolProject
//
//  Created by Li arthur on 16/5/11.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import QuartzCore

class FWIChartViewController: UIViewController, LineChartDelegate {
    
    var lineChart: LineChart!
    var date = [String]()
    var data = [CGFloat]()
    
    @IBOutlet weak var LineGraphView: UIView!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func get(){
         let url = NSURL(string: "http://120.25.241.214:8080/Service1.asmx/selectFWIInfor")
        Alamofire.request(.POST, url!).responseString(encoding: NSUTF8StringEncoding){
            response in
            let responseString = response.result.value!
            //print(responseString)
            let xmlWithNameSpace = responseString
            
            let xml = SWXMLHash.parse(xmlWithNameSpace)
            for i in 0 ..< 10 {
                
                var rawdata = CGFloat(NSNumberFormatter().numberFromString((xml["ArrayOfString"]["string"][9*i + 6].element?.text!)!)!)
                var date =  (xml["ArrayOfString"]["string"][9*i + 8].element?.text!)!
                let index = date.startIndex.advancedBy(9)
                var date1 = date.substringFromIndex(index)
                
                
                self.date.append(date1)
                self.data.append(rawdata)
            }
            
            self.lineChart = LineChart()
            self.lineChart.animation.enabled = true
            self.lineChart.area = true
            self.lineChart.x.labels.visible = true
            self.lineChart.x.grid.count = 5
            self.lineChart.y.grid.count = 5
            //date = ["q","w","e","r","t","2"]
            self.lineChart.x.labels.values = self.date
            self.lineChart.y.labels.visible = true
            //data = [1,2,8,9,18,29]
            self.lineChart.addLine(self.data)
            self.lineChart.translatesAutoresizingMaskIntoConstraints = false
            self.lineChart.delegate = self
            self.LineGraphView.addSubview(self.lineChart)
            
            let horizontalConstraint = self.lineChart.leadingAnchor.constraintEqualToAnchor(self.LineGraphView.leadingAnchor)
            let vertivalConstraint = self.lineChart.centerYAnchor.constraintEqualToAnchor(self.LineGraphView.centerYAnchor)
            let widthConstraint = self.lineChart.widthAnchor.constraintEqualToAnchor(nil, constant: self.view.frame.size.width)
            let heightConstraint = self.lineChart.heightAnchor.constraintEqualToAnchor(nil, constant: 300)
            
            NSLayoutConstraint.activateConstraints([horizontalConstraint, vertivalConstraint, widthConstraint, heightConstraint])
            
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func didSelectDataPoint(x: CGFloat, yValues: Array<CGFloat>) {
        label.text = "         您选择日期为：  \(x)" + " FFWI为:    \(yValues) "
    }
    
    
    
    /**
     * Redraw chart on device rotation.
     */
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if let chart = lineChart {
            chart.setNeedsDisplay()
        }
    }

}
