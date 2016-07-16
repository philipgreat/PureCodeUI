//
//  DetailViewController.swift
//  PureCodeUI
//
//  Created by 张喜来 on 7/16/16.
//  Copyright © 2016 张喜来. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         view.backgroundColor = .redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)");
        
        
        
        let detailController = MoreDetailViewController();
        detailController.title = "More Detail"
        self.navigationController?.pushViewController(detailController, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
