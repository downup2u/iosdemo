//
//  MainNavViewController.swift
//  xkcrm
//
//  Created by 小庆 王 on 15-2-23.
//  Copyright (c) 2015年 wangxiaoqing. All rights reserved.
//

import UIKit

class MainNavViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self         // Do any additional setup after loading the view.
        
        self.navBtns = [NavBtn(name: "lead", desc: "lead", iconimg: "navhome"),
           NavBtn(name: "phonecall", desc: "phonecall", iconimg: "navphonecall")]
    }
    @IBOutlet weak var tableview:UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    struct NavBtn {
        let name: String
        let desc: String
        let iconimg: String
    }
    var navBtns = [NavBtn]()
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "navCell"
        
        var cell: NavTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? NavTableViewCell
        
        if cell == nil {
            cell = NavTableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        //cell!.backgroundColor = UIColor.orangeColor()
        cell!.nameLabel!.text = navBtns[indexPath.row].name
        cell!.iconImageView!.image = UIImage(named:navBtns[indexPath.row].iconimg)
        cell!.descLabel!.text = navBtns[indexPath.row].desc
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navBtns.count
    }
}


