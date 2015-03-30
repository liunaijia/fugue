//
//  ViewController.swift
//  fugue
//
//  Created by njliu on 3/24/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "http://www.infoq.com/cn/news")
        downloadArticles(url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func downloadArticles(articleListUrl: NSURL?) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = InfoQArticleListResponseSerializer()
        //manager.requestSerializer.setValue("text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", forHTTPHeaderField: "Accept")
        manager.GET(articleListUrl?.absoluteString,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                for article in responseObject as [ArticleHeader] {
                    let articleUrl = NSURL(string: article.url!, relativeToURL: articleListUrl)
                    self.downloadArticleBody(articleUrl)
                    break
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                NSLog(error.localizedDescription)
        })
    }
    
    func downloadArticleBody(articleUrl:NSURL?) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = InfoQArticleResponseSerializer()
        //manager.requestSerializer.setValue("text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", forHTTPHeaderField: "Accept")
        manager.GET(articleUrl?.absoluteString,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                let articleBody = responseObject as ArticleBody
                NSLog("\(articleBody)")
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                NSLog(error.localizedDescription)
        })
    }
}

