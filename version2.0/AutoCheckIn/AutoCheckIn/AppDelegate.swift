//
//  AppDelegate.swift
//  AutoCheckIn
//
//  Created by 范天文 on 16/6/6.
//  Copyright © 2016年 范天文. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

//    @IBOutlet weak var window: NSWindow!
    
    let mStatusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)

    let mPopover = NSPopover()
    
    //应用启动的时候
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        if let statusButton = mStatusItem.button{
            statusButton.image=NSImage(named: "AppIcon")
            statusButton.action = Selector("togglePopover")
        }
        
        //设置弹出的主界面
        mPopover.contentViewController = CheckInViewController(nibName:"CheckInViewController",bundle: nil)
        mPopover.behavior = .Transient
        mPopover.animates = false
        mPopover.appearance = NSAppearance(named: NSAppearanceNameAqua)
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func togglePopover(){
        PopoverAction.toggle()
    }


}

