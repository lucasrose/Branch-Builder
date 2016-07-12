//
//  EventMonitor.swift
//  Branch Builder
//
//  Created by Lucas Rose on 7/12/16.
//  Copyright © 2016 Lucas Rose. All rights reserved.
//  Source: https://www.raywenderlich.com/98178/os-x-tutorial-menus-popovers-menu-bar-apps
//

import Cocoa

public class EventMonitor {
    // MARK: Global Variables
    
    private var monitor: AnyObject?
    private let mask: NSEventMask
    private let handler: (NSEvent?) -> ()
    
    // MARK: Constructor
    
    public init(mask: NSEventMask, handler: (NSEvent?) -> ()) {
        self.mask = mask
        self.handler = handler
    }
    
    // MARK: Method Declarations
    
    public func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }
    
    public func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
}
