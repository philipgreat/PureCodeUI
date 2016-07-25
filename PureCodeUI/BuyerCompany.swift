//
//  BuyerCompany.swift
//  PureCodeUI
//
//  Created by 张喜来 on 7/25/16.
//  Copyright © 2016 张喜来. All rights reserved.
//

import Foundation


class CostCenter{
    
}

class CreditAccount{
    
}

class BillingAddress{
    
}

class Order{
    
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
