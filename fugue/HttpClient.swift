//
//  HttpClient.swift
//  fugue
//
//  Created by njliu on 4/1/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation


class HttpClient : NSObject{
    
    class func get<T>(url: NSURL, parameters: AnyObject?, responseSerializer: AFHTTPResponseSerializer, success:(T)->Void) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = responseSerializer
        manager.GET(url.absoluteString,
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                success(responseObject as T)
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                NSLog(error.localizedDescription)
        })
    }
    
    
}