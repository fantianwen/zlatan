//
//  PopoverAction.swift
//  AutoCheckIn
//
//  Created by 范天文 on 16/6/6.
//  Copyright © 2016年 范天文. All rights reserved.
//

import Cocoa

class PopoverAction{
    // 静态计算型属性，监听用户的点击事件，在窗口外点击要关闭窗口
    private class var eventMonitor: EventMonitor? {
        return EventMonitor(mask: [.LeftMouseDownMask, .RightMouseDownMask]) { event in
            close()
        }
    }
    
    // AppDelegate
    private class var appDelegate: AppDelegate {
        return NSApplication.sharedApplication().delegate as! AppDelegate
    }
    
    class func toggle() {
        if appDelegate.mPopover.shown {
            close()
        } else {
            show()
        }
    }
    
    class func close() {
        if !appDelegate.mPopover.shown {
            return
        }
        
        appDelegate.mPopover.close()
        eventMonitor?.stop()
    }
    
    class func show() {
        NSRunningApplication.currentApplication().activateWithOptions(NSApplicationActivationOptions.ActivateIgnoringOtherApps)
        
        guard let button = appDelegate.mStatusItem.button else {
            return
        }
        
        appDelegate.mPopover.showRelativeToRect(button.frame, ofView: button, preferredEdge: .MinY)
        eventMonitor?.start()
    }

}