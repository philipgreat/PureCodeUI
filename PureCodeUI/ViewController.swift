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
    
    
    internal func addTable()
    {
        view.backgroundColor = .yellowColor()
        
        
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        tableView!.delegate      =   self
        tableView!.dataSource    =   self
        tableView!.registerClass(LineItemCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        

    
    }
    internal func reloadDate(){
    
        
        
        let requestURL: NSURL = NSURL(string: "http://www.learnswiftonline.com/Samples/subway.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
            }
            
            
            if (statusCode == 200) {
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    
                    if let stations = json["stations"] as? [[String: AnyObject]] {
                        
                        for station in stations {
                            
                            if let name = station["stationName"] as? String {
                                
                                if let year = station["buildYear"] as? String {
                                    print("name and year = ",name,year)
                                }
                                
                            }
                        }
                        
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
            }
            
        }
        
        task.resume()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addTable()
        reloadDate()
        
        
        
    }
    
     func numberOfSectionsInTableView(_tableView: UITableView) -> Int{
        
        
        print("numberOfSectionsInTableView called")
        
        return 20
    
    }
    
    func tableView( tableView: UITableView,
                     numberOfRowsInSection section: Int) -> Int{
        
        print("tableView( tableView: UITableView,numberOfRowsInSection section: Int) -> Int called")
        
        return 1
    }
    
    func tableView(_tableView: UITableView,
                     sectionForSectionIndexTitle title: String,
                                                 atIndex index: Int) -> Int
    {
        
        print("tableView(_tableView: UITableView,sectionForSectionIndexTitle title: String,atIndex index: Int) ")
        
        return 1;
    
    }
     func tableView(_tableView: UITableView,
                     estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        
        print("tableView(_tableView: UITableView,estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) ")
        
        
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
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected\(indexPath.row)-\(indexPath.section)")
        
        
        let detailController = DetailViewController();
        detailController.title = "Item Detail"
        self.navigationController?.pushViewController(detailController, animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
/*
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 //Get reference to receipt
 Receipt *receipt = [self.receiptsArray objectAtIndex:indexPath.row];
 
 ReceiptDetailViewController *controller = [[ReceiptDetailViewController alloc] initWithNibName:@"ReceiptDetailViewController" bundle:nil];
 
 // Pass data to controller
 controller.receipt = receipt;
 [self.navigationController pushViewController:controller animated:YES];
 }*/
