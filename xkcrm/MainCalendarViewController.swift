//
//  MainCalendarViewController.swift
//  xkcrm
//
//  Created by 小庆 王 on 15-2-23.
//  Copyright (c) 2015年 wangxiaoqing. All rights reserved.
//

import UIKit

class MainCalendarViewController: UIViewController, CVCalendarViewDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.labelMonth.text = CVDate(date: curDate).description()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewHead: CVCalendarMenuView!
    @IBOutlet weak var viewContent: CVCalendarView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewContent.commitCalendarViewUpdate()
        self.viewHead.commitMenuViewUpdate()
    }
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    
    @IBAction func onClickPrev(sender: AnyObject) {
        //viewContent.loadPreviousMonthView()
        toggleMonthViewWithMonthOffset(-1)
    }
    @IBAction func onClickNext(sender: AnyObject) {
       // viewContent.loadNextMonthView()
        toggleMonthViewWithMonthOffset(1)
    }

    
    func didSelectDayView(dayView: CVCalendarDayView) {
        // TODO:
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> UIColor {
        if dayView.date?.day == 3 {
            return .redColor()
        } else if dayView.date?.day == 5 {
            return .blackColor()
        } else if dayView.date?.day == 2 {
            return .blueColor()
        }
        
        return .greenColor()
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        if dayView.date?.day == 3 || dayView.date?.day == 5 || dayView.date?.day == 2 {
            return true
        } else {
            return false
        }
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    var animationFinished = true
    func presentedDateUpdated(date: CVDate) {
        
        let cal = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var components =  cal!.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitWeekday, fromDate: NSDate());
        components.day = date.day!
        components.month = date.month!
        components.year = date.year!
        curDate = cal!.dateFromComponents(components)!
        
        if self.labelMonth.text != date.description() && self.animationFinished  {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = labelMonth.textColor
            updatedMonthLabel.font = labelMonth.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.description
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.labelMonth.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.animationFinished = false
                self.labelMonth.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.labelMonth.transform = CGAffineTransformMakeScale(1, 0.1)
                self.labelMonth.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity
                
                }) { (finished) -> Void in
                    self.animationFinished = true
                    self.labelMonth.frame = updatedMonthLabel.frame
                    self.labelMonth.text = updatedMonthLabel.text
                    self.labelMonth.transform = CGAffineTransformIdentity
                    self.labelMonth.alpha = 1
                    updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.labelMonth)
        }
    }
    var curDate = NSDate()
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        let calendarManager = CVCalendarManager.sharedManager
        let components = calendarManager.componentsForDate(curDate) // from curDate
        
        components.month += offset
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.viewContent.toggleMonthViewWithDate(resultDate)
    }

}
