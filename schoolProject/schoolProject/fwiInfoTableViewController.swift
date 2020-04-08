//
//  fwiInfoTableViewController.swift
//  schoolProject
//
//  Created by Li arthur on 16/4/18.
//  Copyright © 2016年 Li arthur. All rights reserved.
//
import UIKit
import Alamofire
import SWXMLHash
import FoldingCell

class fwiInfoTableViewController: UITableViewController {
    
    let kCloseCellHeight: CGFloat = CGFloat(110) // equal or greater foregroundView height
    let kOpenCellHeight: CGFloat = CGFloat(210) // equal or greater containerView height

    var cellHeights = [CGFloat]()
    
    var fwiInfo = [FWIInfor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        refresh()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 70/255, green: 166/255, blue: 58/255, alpha: 0.7)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        for _ in 0...25{
            cellHeights.append(kCloseCellHeight)
        }
        
    }
    
    func refresh(){
        fwiInfo.removeAll()
        
        let url = NSURL(string: "http://120.25.241.214:8080/Service1.asmx/selectFWIInfor")
        print("1")
        Alamofire.request(.POST, url!).responseString(encoding: NSUTF8StringEncoding){
            response in
            let responseString = response.result.value!
            //print(responseString)
            let xmlWithNameSpace = responseString
            
            let xml = SWXMLHash.parse(xmlWithNameSpace)
            print("2")
            for i in 0 ..< 10 {
                let fwiInfo = FWIInforDic()
                

                fwiInfo.rawData["seven"] = (xml["ArrayOfString"]["string"][9*i + 6].element?.text!)!
                fwiInfo.rawData["eight"] = (xml["ArrayOfString"]["string"][9*i + 7].element?.text!)!
                fwiInfo.rawData["nine"] = (xml["ArrayOfString"]["string"][9*i + 8].element?.text!)!
                if let infoFwi = fwiInfo.fwiInfo{
                    self.fwiInfo.append(infoFwi)
                }
            }
            self.update()
        }
        
    }
    
    func update(){
        print(fwiInfo)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fwiInfo.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fwiCell", forIndexPath: indexPath) as! FWITableViewCell
        
        cell.fwiInfo = fwiInfo[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    //MARK: folding cell
    
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
}
