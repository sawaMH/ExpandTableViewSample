//
//  ViewController.swift
//  ExpandTableViewSample
//
//  Created by sawaMH on 2016/06/13.
//  Copyright © 2016年 sawaMH. All rights reserved.
//

import UIKit

class ViewController: ExpandTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Sample Items
        self.sectionItems.append((expanded: true, title: "Section1", values: ["Row1", "Row2", "Row3"]))
        self.sectionItems.append((expanded: false, title: "Section2", values: ["Row1", "Row2"]))
        self.sectionItems.append((expanded: false, title: "Section3", values: ["Row1", "Row2", "Row3", "Row4"]))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        cell.textLabel!.text = self.sectionItems[indexPath.section].values[indexPath.row] as? String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.section),\(indexPath.row) Taped!")
    }
}
