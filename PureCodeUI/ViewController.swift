//
//  ViewController.swift
//  PureCodeUI
//
//  Created by 张喜来 on 7/15/16.
//  Copyright © 2016 张喜来. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .yellowColor()
        
        
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        tableView!.delegate      =   self
        tableView!.dataSource    =   self
        tableView!.registerClass(LineItemCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        
        
    }
    
     func numberOfSectionsInTableView(_tableView: UITableView) -> Int{
        
        return 20
    
    }
    
    func tableView( tableView: UITableView,
                     numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(_tableView: UITableView,
                     sectionForSectionIndexTitle title: String,
                                                 atIndex index: Int) -> Int
    {
        return 1;
    
    }
    func tableView(_tableView: UITableView,
                     estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 44;
        
    }
    
    func tableView(_tableView: UITableView,
                     cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView!.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath) as! LineItemCell
        cell.dynamicLabel.text = "hello\(indexPath.row)-\(indexPath.section)"
        print("cell text\(cell.dynamicLabel.text)")
        //cell?.textLabel = "love is blue"
        return cell;
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

