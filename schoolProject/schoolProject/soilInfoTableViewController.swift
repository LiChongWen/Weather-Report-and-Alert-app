//
//  soilInfoTableViewController.swift
//  schoolProject
//
//  Created by Li arthur on 16/4/23.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import FoldingCell

class soilInfoTableViewController: UITableViewController {
    
    
    let kCloseCellHeight: CGFloat = CGFloat(110) // equal or greater foregroundView height
    let kOpenCellHeight: CGFloat = CGFloat(210) // equal or greater containerView height
    
    var cellHeights = [CGFloat]()

    var soilInfo = [SoilInfo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        refresh()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 114/255, green: 90/255, blue: 80/255, alpha: 0.7)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        for _ in 0...25{
            cellHeights.append(kCloseCellHeight)
        }
    }

    func refresh(){
        soilInfo.removeAll()
        
        let url = NSURL(string: "http://120.25.241.214:8080/Service1.asmx/selectSoil")
        print("1")
        Alamofire.request(.POST, url!).responseString(encoding: NSUTF8StringEncoding){
            response in
            let responseString = response.result.value!
            //print(responseString)
            let xmlWithNameSpace = responseString
            
            let xml = SWXMLHash.parse(xmlWithNameSpace)
            print("2")
            for i in 0 ..< 10 {
                let soilInforDic = SoilInfoDic()
                
                soilInforDic.rawData["number"] = (xml["ArrayOfString"]["string"][7*i].element?.text!)!
                soilInforDic.rawData["numberOfBase"] = (xml["ArrayOfString"]["string"][7*i + 1].element?.text!)!
                soilInforDic.rawData["temOfSoil"] = (xml["ArrayOfString"]["string"][7*i + 4].element?.text!)!
                soilInforDic.rawData["humOfSoil"] = (xml["ArrayOfString"]["string"][7*i + 5].element?.text!)!
                soilInforDic.rawData["time"] = (xml["ArrayOfString"]["string"][7*i + 6].element?.text!)!
            
                if let soil = soilInforDic.soilInfo{
                    self.soilInfo.append(soil)
                }
            }
            self.update()
        }
        
    }
    
    func update(){
        print("3")
        print(soilInfo)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return soilInfo.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("soilCell", forIndexPath: indexPath) as! soilInfoTableViewCell

        // Configure the cell...
        cell.soilInfo = soilInfo[indexPath.row]
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
