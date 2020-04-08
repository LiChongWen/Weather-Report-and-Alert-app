//
//  infoTableViewController.swift
//  weather
//
//  Created by Li arthur on 16/3/23.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import FoldingCell

class infoTableViewController: UITableViewController {
    
    
    
    //var x = CargoInfoDic()
    
    var caInfo = [CargoInfo]()

    let kCloseCellHeight: CGFloat = CGFloat(110) // equal or greater foregroundView height
    let kOpenCellHeight: CGFloat = CGFloat(210) // equal or greater containerView height
   // var caInfo = [[String:String]]()
    var cellHeights = [CGFloat]()

   
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 2/255, green: 101/255, blue: 124/255, alpha: 0.7)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        refresh()
        for _ in 0...25{
            cellHeights.append(kCloseCellHeight)
        }
        //print("1=\(caInfo)")
       // self.view.backgroundColor = UIColor(red: 61/255, green: 77/255, blue: 100/255, alpha: 0.7)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    
    
    func refresh(){

        caInfo.removeAll()
        
        
        
        let url = NSURL(string: "http://120.25.241.214:8080/Service1.asmx/selectAllCargoInfor")
                
        Alamofire.request(.POST, url!).responseString(encoding: NSUTF8StringEncoding){
         response in
            let responseString = response.result.value!
                    //print(responseString)
            let xmlWithNameSpace = responseString
                    
            let xml = SWXMLHash.parse(xmlWithNameSpace)
            for i in 0 ..< 20 {
                let infoDict = CargoInfoDic()
               
                infoDict.rawData["temp"] = (xml["ArrayOfString"]["string"][5*i].element?.text!)!
                infoDict.rawData["humidity"] = (xml["ArrayOfString"]["string"][5*i+1].element?.text!)!
                infoDict.rawData["rainfall"] = (xml["ArrayOfString"]["string"][5*i+2].element?.text!)!
                infoDict.rawData["fire"] = (xml["ArrayOfString"]["string"][5*i+3].element?.text!)!
                infoDict.rawData["time"] = (xml["ArrayOfString"]["string"][5*i+4].element?.text!)!
                if let cargoInfo = infoDict.cargoInfo {
                    self.caInfo.append(cargoInfo)
                }
            }
             //print(self.caInfo)
            self.updateUI()
        }
    }
    
    func updateUI(){
         print(caInfo)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return caInfo.count
//    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is FoldingCell {
            let foldingCell = cell as! FoldingCell
            
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return caInfo.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! infoTableViewCell
        cell1.cargoInfo = caInfo[indexPath.row]
        // Configure the cell...

        return cell1
    }


   
}
