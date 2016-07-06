//
//  ExpandTableViewController.swift
//  ExpandTableViewSample
//
//  Created by sawaMH on 2016/06/13.
//  Copyright © 2016年 sawaMH. All rights reserved.
//

import UIKit

class ExpandTableViewController: UITableViewController {
    
    let defaultHeaderIdentifier = "ExpandTableHeaderView"
    @IBInspectable var headerIdentifier:String = ""
    
    var sectionItems: [(expanded: Bool, title: String, values: [AnyObject])] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if self.headerIdentifier == "" {
            self.headerIdentifier = self.defaultHeaderIdentifier
        }
        self.tableView.registerNib(UINib(nibName: self.headerIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: self.headerIdentifier)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (self.tableView(tableView, viewForHeaderInSection: section)?.frame.size.height)!
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(self.headerIdentifier) as! ExpandTableHeaderView
        headerView.titleLabel?.text = self.sectionItems[section].title
        headerView.section = section
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ExpandTableViewController.sectionHeaderTaped(_:))))
        return headerView
    }
    
    @objc private func sectionHeaderTaped(recognizer: UITapGestureRecognizer) {
        let headerView = recognizer.view as! ExpandTableHeaderView
        self.sectionItems[headerView.section].expanded = !self.sectionItems[headerView.section].expanded
        
        var indexPaths = [NSIndexPath]()
        for row in 0...(self.sectionItems[headerView.section].values.count - 1) {
            indexPaths.append(NSIndexPath(forRow: row, inSection: headerView.section))
        }
        if self.sectionItems[headerView.section].expanded == true {
            self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
        } else {
            self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionItems.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sectionItems[section].expanded ? self.sectionItems[section].values.count : 0
    }
}

class ExpandTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet var titleLabel: UILabel?
    var section = 0
}