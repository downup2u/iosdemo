//
//  MainViewController.swift
//  xkcrm
//
//  Created by 小庆 王 on 15-2-23.
//  Copyright (c) 2015年 wangxiaoqing. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,DrawerMenuControllerDelegate {

    var currentViewController: UIViewController?
    var currentIndex: Int?
    var allViewControllers: Array<UIViewController> = Array<UIViewController>()


    override func viewDidLoad() {
        super.viewDidLoad()

        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var v0:UIViewController = storyboard.instantiateViewControllerWithIdentifier("lead") as UIViewController
        var v1:UIViewController = storyboard.instantiateViewControllerWithIdentifier("opportunity") as UIViewController
        var v2:UIViewController = storyboard.instantiateViewControllerWithIdentifier("partner") as UIViewController
        var v3:UIViewController = storyboard.instantiateViewControllerWithIdentifier("phonecall") as UIViewController
   

        
        allViewControllers.append(v0)
        allViewControllers.append(v1)
        allViewControllers.append(v2)
        allViewControllers.append(v3)
        
        
        var initSel = 0
        self.currentIndex = initSel
        self.currentViewController = self.allViewControllers[initSel]
        for (var i = 0 ;i < allViewControllers.count ;i++)
        {
            allViewControllers[i].view.frame = self.view.bounds
            addChildViewController(allViewControllers[i])
            self.view.addSubview(allViewControllers[i].view)
            if( i > 0){
                allViewControllers[i].view.hidden = true
            }
        }
        
        self.allViewControllers[initSel].didMoveToParentViewController(self)
        

    }
    
    override func viewDidLayoutSubviews(){
        for (var i = 0 ;i < allViewControllers.count ;i++)
        {
            allViewControllers[i].view.frame = self.view.bounds
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swithToIndex(var newIndex:Int) -> Void {
        if newIndex != self.currentIndex {
            transitionFromOldIndexToNewIndex(self.currentIndex, newIndex: newIndex)
        }
    }
    
    func transitionFromOldIndexToNewIndex(oldIndex: Int!, newIndex: Int!) -> Void {
        let visibleViewController = self.allViewControllers[oldIndex] as UIViewController
        let newViewController = self.allViewControllers[newIndex] as UIViewController
        visibleViewController.view.hidden = true
        newViewController.view.hidden = false
        self.currentViewController = newViewController
        self.currentIndex = newIndex
        
    }
    //DrawerMenuControllerDelegate
    func CustomlayoutViewWithOffset(xoffset: CGFloat, menuController: DrawerMenuController) {
        println(xoffset)
        menuController.mainCurrentViewWithOffset(xoffset)
        if xoffset > 0 {
            menuController.leftSideView!.frame = CGRectMake( ( -menuController.leftSideView!.frame.size.width + xoffset +  xoffset / menuController.leftViewShowWidth * ( menuController.leftSideView!.frame.size.width - xoffset) ) , 0, menuController.leftSideView!.frame.size.width, menuController.leftSideView!.frame.size.height)
            menuController.leftSideView!.alpha = xoffset/menuController.leftViewShowWidth
        }
    }


    @IBAction func onClickMenu(sender: AnyObject) {
        (UIApplication.sharedApplication().delegate as AppDelegate).menuController?.showLeftViewController(true)

    }
    @IBAction func onClickAdd(sender: AnyObject) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
