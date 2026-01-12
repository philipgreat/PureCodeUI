//
//  LineItemCell.swift
//  PureCodeUI
//
//  Created by 张喜来 on 7/16/16.
//  Copyright © 2016 张喜来. All rights reserved.
//

import UIKit

class LineItemCell: UITableViewCell {
    
    
    
    
    var  idLabel : UILabel!
    var  thumbImage: UIImage!
    
    var  nameLabel : UILabel!
    
    var  qtyLabel : UILabel!
    var  amountLabel : UILabel!
    
    
    
    func log(message:String)
    {
        if true {return}
        NSLog(message)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        //With code, this method will be called
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        idLabel = UILabel(frame: CGRectMake(10, 10, 80, 40))
        idLabel!.textColor = UIColor.brownColor()
        
       
        //idLabel!.font = //set font here
        
        addSubview(idLabel)
        
        
        nameLabel = UILabel(frame: CGRectMake(100, 10, 120, 40))
        nameLabel!.textColor = UIColor.redColor()
        
        addSubview(nameLabel)
        
        
        qtyLabel = UILabel(frame: CGRectMake(230, 10, 60, 40))
        qtyLabel!.textColor = UIColor.brownColor()
        
        
        //idLabel!.font = //set font here
        
        addSubview(qtyLabel)
        
        
        
        //log("method called")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        //idLabel.frame = CGRectMake(50, 150, 200, 21)
       
        
        
        
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
