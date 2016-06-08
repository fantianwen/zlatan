//
//  EventMonitor.swift
//  AutoCheckIn
//
//  Created by 范天文 on 16/6/6.
//  Copyright © 2016年 范天文. All rights reserved.
//

import Cocoa

class EventMonitor{
    private var monitor: AnyObject?
    private let mask: NSEventMask
    private let handler: NSEvent? -> () // 回调函数
    
    init(mask: NSEventMask, handler: NSEvent? -> ()) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    func start() {
        monitor = NSEvent.addGlobalMonitorForEventsMatchingMask(mask, handler: handler)
    }
    
    func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }

}
