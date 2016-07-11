//
//  StatusViewController.swift
//  Branch Builder
//
//  Created by Lucas Rose on 7/11/16.
//  Copyright © 2016 Lucas Rose. All rights reserved.
//

import Cocoa

class StatusViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var branchName: NSTextField!
    
    let data = ["LINT-COMPILE", "PYTHON", "RUBY-LINT", "UNIT INTEGRATION", "BRANCH ACCEPTANCE", "DIST"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        //var image:NSImage?
        if let cell = tableView.make(withIdentifier: "TestNameCell", owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = data[row]
            setTestImage(cell: cell, iconName: "test-icon-in-progress")
            return cell
        }
        return nil
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return data.count
    }
    
    func setTestImage(cell: NSTableCellView, iconName: String!) {
        let icon = NSImage(named: iconName)
        cell.imageView?.image = icon
    }
}
