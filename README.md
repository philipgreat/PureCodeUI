# PureCodeUI

##POD Integration

sudo gem install cocoapods


pod setup

goto project folder 

pod init to get a Podfile

Add dependencies


pod install


##Alamofire and SwiftyJSON


import Alamofire
import SwiftyJSON



class RemoteService

{
    

    init()
    {
        //super.init()
    }
    func request(){
       
        
        let headers = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Content-Type": "application/x-www-form-urlencoded",
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

