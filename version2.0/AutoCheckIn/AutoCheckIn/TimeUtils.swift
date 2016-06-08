//
//  TimeUtils.swift
//  AutoCheckIn
//
//  Created by 范天文 on 16/6/7.
//  Copyright © 2016年 范天文. All rights reserved.
//

import Foundation


class TimeUtils{
    
    
    class func getTimePrefix()->String{
        
        let now = NSDate()
        let das = NSCalendar.currentCalendar()
        
        let nowCom = das.components([.NSYearCalendarUnit,.NSMonthCalendarUnit,.NSDayCalendarUnit,.NSHourCalendarUnit,.NSMinuteCalendarUnit,.NSSecondCalendarUnit], fromDate: now)
        
        let year = nowCom.year
        let month = nowCom.month
        let day = nowCom.day
        //        let hour = nowCom.hour
        //        let minute = nowCom.minute
        //        let second = nowCom.second
        
        //        return "\(year)-\(month)-\(day) \(hour):\(minute):\(second)"
        return "\(year)-\(month)-\(day) "
        
    }
    
    
    
    class func getTimeInterval(date:String)->Double{

        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        let dateSet = dateFormatter.dateFromString(date)
        let delta = NSDate().timeIntervalSinceDate(dateSet!)
        
        return -delta
        
    }

    
    class func timeDispatch(delay:Double,closure:()->()){
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }
    
}
