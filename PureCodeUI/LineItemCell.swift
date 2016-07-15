//
//  LineItemCell.swift
//  PureCodeUI
//
//  Created by 张喜来 on 7/16/16.
//  Copyright © 2016 张喜来. All rights reserved.
//

import UIKit

class LineItemCell: UITableViewCell {
    
    
    
    
    var  dynamicLabel : UILabel!
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        //With code, this method will be called
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dynamicLabel = UILabel(frame: CGRectMake(10, 10, 100.0, 40))
        dynamicLabel!.textColor = UIColor.blackColor()
        //dynamicLabel!.font = //set font here
        
        addSubview(dynamicLabel)
        print("method called")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        //dynamicLabel.frame = CGRectMake(50, 150, 200, 21)
       
        
        
        
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
