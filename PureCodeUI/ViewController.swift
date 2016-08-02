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
import ObjectMapper




struct CreditAccount: CustomStringConvertible, Mappable{
    
    var	id                  :	String?
    var	name                :	String?

    var	authorized          :	Double?
    var	remain              :	Double?
    var	version             :	Int?
    
    
    init?(_ map: Map){
    
    }
    
    init(){
        //lazy load for all the properties
        //This is good for UI applications as it might saves RAM which is very expensive in mobile devices
        
    }
    
    //Confirming to the protocol Mappable of ObjectMapper
    //Reference on https://github.com/Hearst-DD/ObjectMapper/
    mutating func mapping(map: Map) {
        //Map each field to json fields
        id                  	<- map["id"]
        name                	<- map["name"]
        authorized          	<- map["authorized"]
        remain              	<- map["remain"]
        version             	<- map["version"]
        
        
    }//end func mapping(map: Map)
    
    
    
    //Confirming to the protocol CustomStringConvertible of Foundation
    var description: String{
        //Need to find out a way to improve this method performance as this method might called to
        //debug or log, using + is faster than \(var).
        
        var result = "credit_account{";
        result += "\tid='\(id)';"
        result += "\tname='\(name)';"
     
        result += "\tauthorized='\(authorized)';"
        result += "\tremain='\(remain)';"
        result += "\tversion='\(version)';"
        result += "}";
        
        return result
    }
    
    static var 	CLASS_VERSION = "1" 
    //This value is for serializer like message pack to identify the versions match between
    //local and remote object.
    
}


class EmployeeRemoteManagerImpl: CustomStringConvertible{
    
    let remoteURLPrefix = "http://127.0.0.1:8080/naf/employeeManager/"
    internal func compositeCallURL(methodName: String, parameters:[String]) -> String
    {
        var resultURL = remoteURLPrefix
        /* This will be available in Swift 3.0
         resultURL.append(methodName)
         resultURL.append("/")
         */
        resultURL += methodName
        resultURL += "/"
        
        for parameter in parameters{
            /*	This will be available in Swift 3.0
             resultURL.append(parameter)
             resultURL.append("/")
             */
            resultURL += parameter
            resultURL += "/"
            
        }
        return resultURL
        
    }
    
    
    
    
    
    internal func compositeCallURL(methodName: String) -> String
    {
        //Simple method, do not need to call compositeCallURL(methodName: String, parameters:[String]) -> String
        var resultURL = remoteURLPrefix
        /*	This will be available in Swift 3.0
         resultURL.append(methodName)
         resultURL.append("/")
         */
        resultURL += methodName
        resultURL += "/"
        return resultURL
        
    }
    
    
    init(){
        //lazy load for all the properties
        //This is good for UI applications as it might saves RAM which is very expensive in mobile devices
        
    }

    
    //Confirming to the protocol CustomStringConvertible of Foundation
    var description: String{
        //Need to find out a way to improve this method performance as this method might called to
        //debug or log, using + is faster than \(var).
        let result = "EmployeeRemoteManagerImpl, V1. Configured with URL: " + remoteURLPrefix
        return result
    }
    static var 	CLASS_VERSION = 1
    //This value is for serializer like message pack to identify the versions match between
    //local and remote object.
    
    
}



class B2BJsonTool{


    func extractLineItemFromJSON(json:JSON) -> LineItem{
        
        var lineItem = LineItem()
        
        if let id = json["id"].string {
            lineItem.id = id
        }
        if let skuId = json["skuId"].string {
            lineItem.skuId = skuId
        }
        if let skuName = json["skuName"].string {
            lineItem.skuName = skuName
        }
        if let amount = json["amount"].double {
            lineItem.amount = amount
        }
        if let quantity = json["quantity"].int {
            lineItem.quantity = quantity
        }
        if let version = json["version"].int {
            lineItem.version = version
        }
        if let active = json["active"].bool {
            lineItem.active = active
        }
        
        return lineItem
        
    }
    
    
    func extractLineItemListFromJSON(json:JSON) -> [LineItem]?{
        
        var lineItemList = [LineItem]()
        
        guard let lineItemJsonList = json.array else{
            print("there is an error here, the json is nil or it can not convert into array: \(json) !")
            return lineItemList
        }
        
        
        for element in lineItemJsonList{
            let lineItem = extractLineItemFromJSON(element)
            lineItemList.append(lineItem)
        }
        
        return lineItemList
        
    }
    
    
    func extractOrderFromJSON(json:JSON) -> Order{
        var order = Order()
        
        order.title = json["title"].string
        //order.lineItemList = json["lineItemList"].array
        
        order.lineItemList = extractLineItemListFromJSON(json["lineItemList"])
        return order
    }
    
    func extractSellerFromJSON(json:JSON) -> Order{
        var order = Order()
        
        order.title = json["title"].string
        //order.lineItemList = json["lineItemList"].array
        
        order.lineItemList = extractLineItemListFromJSON(json["lineItemList"])
        return order
    }
    

}


class OrderRemoteService

{
    

    
    let remoteURLPrefix = "http://127.0.0.1:8080/naf/orderManager/"
    internal func compositeCallURL(methodName: String, parameters:[String]) -> String
    {
        var resultURL = remoteURLPrefix
        /* This will be available in Swift 3.0
         resultURL.append(methodName)
         resultURL.append("/")
         */
        resultURL += methodName
        resultURL += "/"
        
        for parameter in parameters{
            /*	This will be available in Swift 3.0
             resultURL.append(parameter)
             resultURL.append("/")
             */
            resultURL += parameter
            resultURL += "/"
            
        }
        return resultURL
        
    }
    
    init()
    {
        //super.init()
    }
    func loadOrderDetail(orderId:String, orderSuccessAction: (Order)->String, orderErrorAction: (NSError)->String){
    
        let methodName = "loadOrderDetail"
        let parameters = [orderId]
        

        let url = compositeCallURL(methodName, parameters: parameters)
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let tool = B2BJsonTool();
                    
                    let order = tool.extractOrderFromJSON(json)
                    orderSuccessAction(order)
                }
                
            case .Failure(let error):
                print(error)
                orderErrorAction(error)
            }
        }
    
    }
    //Reference http://stackoverflow.com/questions/28365939/how-to-loop-through-json-with-swiftyjson
    
    func viewJson(json: JSON)
    {
        print("JSON: \(json["profitCenter"] )")

        
    }
    

}





class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView:UITableView?
    var order:Order?
    
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
    func log(message:String)
    {
        if false {
            NSLog(message)
            
        }
        
    }
    internal func reloadData(){
    
        let removeService = OrderRemoteService()
        
        //removeService.loadOrderDetail("O000001")
        
        removeService.loadOrderDetail("O000002",orderSuccessAction: doOrderSuccess, orderErrorAction: doOrderError)
        

    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addTable()
        reloadData()
        
        
        
    }
    
    func doOrderSuccess(order:Order) -> String
    {
        
        let message = "Do order right: \(order)";
        
        self.order = order
        
        
        print(order.title)
        
        for lineItem in order.lineItemList!{
            print(lineItem)
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //must be  in UI thread to load the data, otherwise, some time not working before click some cell
            self.tableView?.reloadData()
            self.refreshControl.endRefreshing()
        })
        
        
        return message
    
    }
    func doOrderError(error:NSError) -> String
    {
        
        let result = "Do order wrong: \(error)"
        
        print(result)
        
        return result
        
        
        
    }
    
     func numberOfSectionsInTableView(_tableView: UITableView) -> Int{
        
        
        log("numberOfSectionsInTableView called")
        
        //NSLog( "calling: %s", __PRETTY_FUNCTION__ );
        
        if order == nil {
            return 0;
        }
        
        return (order?.lineItemList?.count)!
    
    }
    
    func tableView( tableView: UITableView,
                     numberOfRowsInSection section: Int) -> Int{
        
        log("tableView( tableView: UITableView,numberOfRowsInSection section: Int) -> Int called")
        
        return 1
    }
    
    func tableView(_tableView: UITableView,
                     sectionForSectionIndexTitle title: String,
                                                 atIndex index: Int) -> Int
    {
        
        log("tableView(_tableView: UITableView,sectionForSectionIndexTitle title: String,atIndex index: Int) ")
        
        return 1;
    
    }
     func tableView(_tableView: UITableView,
                     estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        
        log("tableView(_tableView: UITableView,estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) ")
        
        
        return 44;
        
    }
    
     func tableView(_tableView: UITableView,
                     cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView!.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath) as! LineItemCell
        
        
        if order == nil {
            return cell //just empty cell when null
        }
        
        log("current sec \(indexPath.section) and current row\(indexPath.row)")
        //cell.dynamicLabel.text = "hello\(indexPath.row)-\(indexPath.section)"
        if indexPath.section < order?.lineItemList?.count {
            let lineItem = order!.lineItemList![indexPath.section]
            cell.dynamicLabel.text = "\(lineItem.skuId!)|\(lineItem.skuName!)|\(lineItem.quantity!) "
           
            
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
