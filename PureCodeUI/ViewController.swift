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
    var items:[[String: AnyObject]]?
    
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
    
        
        
        let requestURL: NSURL = NSURL(string: "http://localhost:8080/naf/service/loadOne/")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        urlRequest.addValue("text/json", forHTTPHeaderField: "Accept")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully. with data \(data)")
            }
            
            
            if (statusCode == 200) {
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    //print("with json: ", json)
                    if let lineItemList = json["lineItemList"] as? [[String: AnyObject]] {
                       
                        
                        self.items = lineItemList
                        
                        for lineItem in lineItemList {
                            
                            if let skuId = lineItem["skuId"] as? String {
                                 print("with line item json: ", skuId);
                                if let quantity = lineItem["quantity"] as? Int {
                                    // the tyoe can not be automatiically transfer, it must match the original ones.
                                    //NSLog("with line item quantity: ", quantity);
                                    NSLog("id and quantity = %@   %d",skuId,quantity)
                                }
                                
                            }
                        }
                        
                    }
                    
                }catch {
                    NSLog("Error with Json: \(error)")
                }
                //self.
                
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //must be  in UI thread to load the data, otherwise, some time not working before click some cell
                self.tableView?.reloadData()
            })
            //self.tableView?.reloadData()
            //NSLog("trying to reload the data")
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
        
        
        NSLog("numberOfSectionsInTableView called")
        
        //NSLog( "calling: %s", __PRETTY_FUNCTION__ );
        
        if items == nil {
            return 0;
        }
        
        return (items?.count)!
    
    }
    
    func tableView( tableView: UITableView,
                     numberOfRowsInSection section: Int) -> Int{
        
        NSLog("tableView( tableView: UITableView,numberOfRowsInSection section: Int) -> Int called")
        
        return 1
    }
    
    func tableView(_tableView: UITableView,
                     sectionForSectionIndexTitle title: String,
                                                 atIndex index: Int) -> Int
    {
        
        NSLog("tableView(_tableView: UITableView,sectionForSectionIndexTitle title: String,atIndex index: Int) ")
        
        return 1;
    
    }
     func tableView(_tableView: UITableView,
                     estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        
        NSLog("tableView(_tableView: UITableView,estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) ")
        
        
        return 44;
        
    }
    
     func tableView(_tableView: UITableView,
                     cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView!.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath) as! LineItemCell
        
        
        if items == nil {
            return cell //just empty cell when null
        }
        
        NSLog("current sec \(indexPath.section) and current row\(indexPath.row)")
        //cell.dynamicLabel.text = "hello\(indexPath.row)-\(indexPath.section)"
        if indexPath.section < items?.count {
            let lineItem = items![indexPath.section]
            if let skuId = lineItem["skuId"] as? String {
                print("with line item json: ", skuId);
                if let quantity = lineItem["quantity"] as? Int {
                    // the tyoe can not be automatiically transfer, it must match the original ones.
                    //NSLog("with line item quantity: ", quantity);
                    
                    
                    if let skuName = lineItem["skuName"] as? String {
                        cell.dynamicLabel.text = "\(skuId)|\(skuName)|\(quantity) "
                    }
                    
                    //NSLog("id and quantity = %@   %d",skuId,quantity)
                }
            }
            
           
            
            //cell.dynamicLabel.text = "hello\(indexPath.row)-\(indexPath.section)"
            
        
        }else{
        
             //cell.dynamicLabel.text = "hello\(indexPath.row)-\(indexPath.section)"
        }
        
        
        //print("cell text\(cell.dynamicLabel.text)")
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
 
 
 curl 'http://localhost:8080/naf/service/loadOne/' -H 'Accept: text/json'



 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 //Get reference to receipt
 Receipt *receipt = [self.receiptsArray objectAtIndex:indexPath.row];
 
 ReceiptDetailViewController *controller = [[ReceiptDetailViewController alloc] initWithNibName:@"ReceiptDetailViewController" bundle:nil];
 
 // Pass data to controller
 controller.receipt = receipt;
 [self.navigationController pushViewController:controller animated:YES];
 }*/
