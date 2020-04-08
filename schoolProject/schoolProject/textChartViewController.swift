//
//  textChartViewController.swift
//  schoolProject
//
//  Created by Li arthur on 16/3/29.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import QuartzCore

class textChartViewController: UIViewController, LineChartDelegate {

    @IBOutlet weak var label: UILabel!
    //var label = UILabel()
    var lineChart: LineChart!
    var data = [CGFloat]()
    
    var date = [String]()
    
    @IBOutlet weak var LineGraphView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        
        
    }
    
    func get(){
        let url = NSURL(string: "http://120.25.241.214:8080/Service1.asmx/selectAllCargoInfor")
        
        Alamofire.request(.POST, url!).responseString(encoding: NSUTF8StringEncoding){
            response in
            let responseString = response.result.value!
            //print(responseString)
            let xmlWithNameSpace = responseString
            
            let xml = SWXMLHash.parse(xmlWithNameSpace)
            for(var i=0; i<5; i++){
                
                var rawdata = CGFloat(NSNumberFormatter().numberFromString((xml["ArrayOfString"]["string"][5*i].element?.text!)!)!)
                var date =  (xml["ArrayOfString"]["string"][5*i+4].element?.text!)!
                self.date.append(date)
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
    


    func didSelectDataPoint(x: CGFloat, yValues: Array<CGFloat>) {
        label.text = "         您选择日期的温度为:    \(yValues) 度"
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
