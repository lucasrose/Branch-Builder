//
//  StatusViewController.swift
//  Branch Builder
//
//  Created by Lucas Rose on 7/11/16.
//  Copyright © 2016 Lucas Rose. All rights reserved.
//

import Cocoa

class StatusViewController: NSViewController {

    @IBOutlet weak var lintCompileTestStatus: NSImageView!
    @IBOutlet weak var pythonTestStatus: NSImageView!
    @IBOutlet weak var rubyLintTestStatus: NSImageView!
    @IBOutlet weak var unitIntegrationTestStatus: NSImageView!
    @IBOutlet weak var branchAcceptanceTestStatus: NSImageView!
    @IBOutlet weak var distTestStatus: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
}
