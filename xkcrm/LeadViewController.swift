//
//  LeadViewController.swift
//  xkcrm
//
//  Created by 小庆 王 on 15-2-23.
//  Copyright (c) 2015年 wangxiaoqing. All rights reserved.
//

import UIKit

class LeadViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self
        
        refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var tableview: UITableView!
    var leadArray = [db_crm_lead]()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func refreshData(){
        
        dispatch_async(dispatch_get_main_queue(),{
            
            for(var i = 0; i < 10; i++ ) {
                var lead1 = db_crm_leadBuilder()
                lead1.uuidleadid = "aa"
                lead1.types = "crm_lead"
                lead1.uuiduserid = "aaaa"
                lead1.uuidpartnerid = "aaaa"
                
                lead1.name = "aa"
                lead1.dateDeadline = "2015-10-23"
                lead1.street2 = "Minghuangjie"
                lead1.contactName = "wangxiaoqing"
                lead1.phone = "15961125167"
                self.leadArray.append(lead1.build())
            }
            self.tableview.reloadData()
        });
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "cellLead"
        
        var cell: LeadTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? LeadTableViewCell
        
        if cell == nil {
            cell = LeadTableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        //cell!.backgroundColor = UIColor.orangeColor()
        cell!.nameLabel!.text = leadArray[indexPath.row].name
        cell!.addressLabel!.text = leadArray[indexPath.row].street2
        cell!.dateLabel!.text = leadArray[indexPath.row].dateDeadline
        cell!.contactLabel!.text = leadArray[indexPath.row].contactName
        cell!.phoneLabel!.text = leadArray[indexPath.row].phone
       
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leadArray.count
    }

}
