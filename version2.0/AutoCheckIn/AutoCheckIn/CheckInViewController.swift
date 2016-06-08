//
//  CheckInViewController.swift
//  AutoCheckIn
//
//  Created by 范天文 on 16/6/6.
//  Copyright © 2016年 范天文. All rights reserved.
//

import Cocoa

class CheckInViewController: NSViewController,NSUserNotificationCenterDelegate{
    
    
    @IBOutlet weak var mUserCode: NSTextFieldCell!
    @IBOutlet weak var mPassword: NSSecureTextField!
    @IBOutlet weak var amHour: NSTextField!
    @IBOutlet weak var amMinute: NSTextField!
    @IBOutlet weak var pmHour: NSTextField!
    @IBOutlet weak var pmMinute: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.checkInWhiteColor().CGColor
        
        
    }
    
    func userNotificationCenter(center: NSUserNotificationCenter, shouldPresentNotification notification: NSUserNotification) -> Bool {
        return true
    }
    
    //全部设定成功
    @IBAction func settingSuccess(sender: AnyObject) {
        
        let timePrefix = TimeUtils.getTimePrefix()
        
        let amTimeSuffix = "\(amHour.stringValue):\(amMinute.stringValue):00"
        
        let pmTimeSuffix = "\(pmHour.stringValue):\(pmMinute.stringValue):00"
        
        let amSettedTime = "\(timePrefix)\(amTimeSuffix)"
        let pmSettedTime = "\(timePrefix)\(pmTimeSuffix)"
        
        print(amSettedTime)
    
        print(pmSettedTime)
        
        let amIntervalTime = TimeUtils.getTimeInterval(amSettedTime)
        let pmIntervalTime = TimeUtils.getTimeInterval(pmSettedTime)
        
        sendNotification("少女祈祷中~")
        if showAlert(){
//            lable1.stringValue="working。。。"
            sendNotification("施法成功 :-D")
//            state = true
            
            TimeUtils.timeDispatch(amIntervalTime){
                
                self.executeCommand("/usr/local/bin/python3", args: ["/Users/RadAsm/pythonProjects/auto_login/daka/main.py", "\(self.mUserCode.stringValue)","\(self.mPassword.stringValue)"])
                print("this is fucking awesome!")
                
            }
            
            TimeUtils.timeDispatch(pmIntervalTime){
                
                self.executeCommand("/usr/local/bin/python3", args: ["/Users/RadAsm/pythonProjects/auto_login/daka/main.py", "\(self.mUserCode.stringValue)","\(self.mPassword.stringValue)"])
                print("this is fucking awesome!")
                
            }
            
            
        }else{
            sendNotification("祈祷失败的说~")
//            state = false
        }
        

        
        
    }
    
    
    func executeCommand(command: String, args: [String]) -> String {
        
        let task = NSTask()
        
        task.launchPath = command
        task.arguments = args
        
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
        
        return output
    }
    
    
    
    func showAlert()->Bool{
        let alertView:NSAlert = NSAlert()
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Cancle")
        alertView.messageText = "开始魔法吟唱~"
        alertView.informativeText = "￥##￥%……&*（&……%￥%……"
        let res = alertView.runModal()
        if res == NSAlertFirstButtonReturn{
            return true
        }
        return false
        
    }

    
    
    // 发送系统通知
    func sendNotification(text:String) {
        let notification = NSUserNotification()
        notification.title = "设定打卡时间"
        notification.informativeText = text
        // notification.contentImage = NSImage(named: "AppIcon") // 并非用来设置通知的logo
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }

    
    
}
