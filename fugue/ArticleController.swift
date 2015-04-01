//
//  ArticleController.swift
//  fugue
//
//  Created by njliu on 3/31/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation

class ArticleController : UIViewController {
    var article: Article?
    
    @IBOutlet weak var contentView: UIWebView!
    
    override func viewDidLoad() {
        if let content = article?.content {
            let html = "<html><body>\(content)</body></html>"
            contentView.loadHTMLString(html, baseURL: nil)
        }
    }
}