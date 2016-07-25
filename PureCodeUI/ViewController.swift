//
//  ViewController.swift
//  PureCodeUI
//
//  Created by 张喜来 on 7/15/16.
//  Copyright © 2016 张喜来. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON



class RemoteService

{
    

    init()
    {
        //super.init()
    }
    func request(){
       
        
//        let headers = [
//            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
//            "Content-Type": "application/x-www-form-urlencoded",
//            "Accept": "applicaton/json",
//            
//        ]
//        
                let headers = [
                    "Accept": "applicaton/json",
        
                ]
                

        
        let url="http://192.168.1.206:8080/naf/orderManager/loadOrderDetail/O000009/"
        Alamofire.request(.GET, url, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                }
            case .Failure(let error):
                print(error)
            }
        }
    
    }

}





class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView:UITableView?
    var items:[[String: AnyObject]]?
    
    var refreshControl: UIRefreshControl!
    
    
    internal func addTable()
    {
        view.backgroundColor = .yellowColor()
        
        
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        tableView!.delegate      =   self
        tableView!.dataSource    =   self
        tableView!.registerClass(LineItemCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        
        refreshControl = UIRefreshControl()
        
        refreshControl.backgroundColor = UIColor.redColor()
        refreshControl.tintColor = UIColor.yellowColor()
        
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
    
        
        tableView?.addSubview(refreshControl)
        
        
      
        
        
    
    }
    /*
     
     
     curl 'http://localhost:8080/naf/orderManager/loadOrderDetail/O000009/'
     '
     */
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        reloadData()
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //            meals.removeAtIndex(indexPath.row)
            //            saveMeals()
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            return
            
        }
        
        if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    internal func reloadData(){
    
        let url = "http://192.168.1.206:8080/naf/orderManager/loadOrderDetail/O000009/"
        //let url = "http://172.20.10.9:8080/naf/orderManager/loadOrderDetail/O000009/"
        
        NSLog("Trying to make a url call")
        
        let requestURL: NSURL = NSURL(string: url )!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        urlRequest.addValue("text/json", forHTTPHeaderField: "Accept")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            if ((error) != nil) {
                print("dataTaskWithRequest error: \(error)");
                return;
            }
            
            
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode != 200) {
                print("Everyone is not fine, file downloaded fail. with data \(statusCode)")
            }
            
            
            if (statusCode == 200) {
                print("Everyone is  fine, file downloaded success. with data \(data)")
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    //print("with json: ", json)
                    if let lineItemList = json["lineItemList"] as? [[String: AnyObject]] {
                       
                        self.updateViewWithNewItems(lineItemList)
                       
                        
                    }
                    
                }catch {
                    NSLog("Error with Json: \(error)")
                }
                //self.
                
            }
            
            //self.tableView?.reloadData()
            //NSLog("trying to reload the data")
        }
        
        task.resume()

    }
    
    
    func updateViewWithNewItems(lineItemList: AnyObject)
    {
        self.items = lineItemList as? [[String : AnyObject]]
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //must be  in UI thread to load the data, otherwise, some time not working before click some cell
            self.tableView?.reloadData()
            self.refreshControl.endRefreshing()
        })
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addTable()
        reloadData()
        
        let removeService = RemoteService()
        
        removeService.request()
        
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
                print("with line item json: ", skuId)
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
