//
//  InfoQDataSource.swift
//  fugue
//
//  Created by njliu on 4/8/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation

class InfoQDataSource {
    let BASE_URL = "http://www.infoq.com/cn/"
    
    // http://www.infoq.com/cn/news/123
    func getList(#section: String, start: Int, done:([ArticleHeader])->Void) {
        let url = NSURL(string: "\(BASE_URL)\(section)/\(start)")
        HttpClient.get(url!, parameters: nil, responseSerializer: InfoQArticleListResponseSerializer()) {
            (articleHeaders: [ArticleHeader]) -> Void in
            done(articleHeaders)
        }
    }
    
    func getDetails(url: String, done:(ArticleBody)->Void) {
        let detailUrl = NSURL(string: url, relativeToURL: NSURL(string: BASE_URL))
        HttpClient.get(detailUrl!, parameters: nil, responseSerializer: InfoQArticleResponseSerializer()) {
            (articleBody: ArticleBody) -> Void in
            done(articleBody)
        }
    }
}