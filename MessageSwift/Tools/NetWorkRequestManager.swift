//
//  NetWorkRequestManager.swift
//  MessageSwift
//
//  Created by 曹云霄 on 16/3/15.
//  Copyright © 2016年 caoyunxiao. All rights reserved.
//

import Foundation
//import Alamofire

typealias Succeed = (NSURLSessionDataTask!,AnyObject!)->Void
typealias Failure = (NSURLSessionDataTask!,NSError!)->Void

class NetWorkRequestManager: NSObject {

    class Singleton {
        
        static let Manager: NetWorkRequestManager = NetWorkRequestManager()
    }
    
    
    
    
    func RequestData(requesturl: String?,parameters: AnyObject?,succeedReturn: Succeed,FailureReturn: Failure){
        

        
    }
    
    
    
    
    
}
