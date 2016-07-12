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
    
    let tests = [
        TestType.LINT_COMPILE,
        TestType.PYTHON,
        TestType.RUBY_LINT,
        TestType.UNIT_INTEGRATION,
        TestType.BRANCH_ACCEPTANCE,
        TestType.DIST
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBranchName(name: "NEW BRANCH")
        buildCurrentBranch(branch: branchName.stringValue)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let cell = tableView.make(withIdentifier: "TestNameCell", owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = tests[row].rawValue
            setTestImage(cell: cell, iconName: "test-icon-in-progress")
            return cell
        }
        return nil
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tests.count
    }
    
    func setTestImage(cell: NSTableCellView, iconName: String!) {
        let icon = NSImage(named: iconName)
        cell.imageView?.image = icon
    }
    
    //MARK: Helper Methods
    
    func setBranchName(name: String){
        //get branch name by main popup
        branchName.stringValue = getAppDelegate().branchName!
    }
    
    func buildCurrentBranch(branch: String){
        //API CALL HERE
    }
    
    func getAppDelegate() -> AppDelegate {
        let appDelegate = NSApplication.shared().delegate as! AppDelegate
        return appDelegate
    }
}
