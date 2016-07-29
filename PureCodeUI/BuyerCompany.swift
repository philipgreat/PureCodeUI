//
//  BuyerCompany.swift
//  PureCodeUI
//
//  Created by 张喜来 on 7/25/16.
//  Copyright © 2016 张喜来. All rights reserved.
//

import Foundation
import ObjectMapper

class CostCenter{
    
}

struct LineItem: CustomStringConvertible{
    
    var	id                  :	String?
    var	bizOrder            :	Order?
    var	skuId               :	String?
    var	skuName             :	String?
    var	amount              :	Double?
    var	quantity            :	Int?
    var	active              :	Bool?
    var	version             :	Int?
    
    
    
    
    
    
    init(){
        //lazy load for all the properties
        //This is good for UI applications as it might saves RAM which is very expensive in mobile devices
        
    }
    
    //Confirming to the protocol Mappable of ObjectMapper
    //Reference on https://github.com/Hearst-DD/ObjectMapper/
    
    init?(_ map: Map){
        
    }
    
    
    
    
    //Confirming to the protocol CustomStringConvertible of Foundation
    var description: String{
        //Need to find out a way to improve this method performance as this method might called to
        //debug or log, using + is faster than \(var).
        
        var result = "line_item{";
        result += "\tid='\(id)';"
        //result += "\tbiz_order='order("+getBizOrder().getId()+")';"
        result += "\tsku_id='\(skuId)';"
        result += "\tsku_name='\(skuName)';"
        result += "\tamount='\(amount)';"
        result += "\tquantity='\(quantity)';"
        result += "\tactive='\(active)';"
        result += "\tversion='\(version)';"
        result += "}";
        
        return result
    }
    
    static var 	CLASS_VERSION = "1" 
    //This value is for serializer like message pack to identify the versions match between
    //local and remote object.
    
}



class BillingAddress{
    
}

struct Order{
    var title: String?
    var	lineItemList        :	[LineItem]?
    
}

extension Order: CustomStringConvertible{

    var description: String{
        let result = "Order with title: " + title!
        return result
    }
    
}

class Employee{
    
}
class BuyerCompany: CustomStringConvertible{
    
    var			id                  :	String?
    var			name                :	String?
    var			priceList           :	String?
    var			rating              :	Int?
    var			logo                :	String?
    var			owner               :	String?
    var			founded             :	NSDate?
    var			version             :	Int?
    
    
    var		costCenterList      :	[CostCenter]?
    var		creditAccountList   :	[CreditAccount]?
    var		billingAddressList  :	[BillingAddress]?
    var		employeeList        :	[Employee]?
    var		orderList           :	[Order]?
    
    
    init(){
        //lazy load for all the properties
        //This is good for UI applications as it might saves RAM which is very expensive in mobile devices
        
    }
    
    
    
    var description: String{
        //Need to find out a way to improve this method performance as this method might called to
        //debug or log, using + is faster than \(var).
        
        var result = "buyer_company{"
        result += "\tid='\(id)';"
        result += "\tname='\(name)';"
        result += "\tprice_list='\(priceList)';"
        result += "\trating='\(rating)';"
        result += "\tlogo='\(logo)';"
        result += "\towner='\(owner)';"
        result += "\tfounded='\(founded)';"
        result += "\tversion='\(version)';"
        result += "}";
        
        return result
    }
    
    static var 	CLASS_VERSION = "1" //This value is for serializer like message pack to identify the current version.
    
}
