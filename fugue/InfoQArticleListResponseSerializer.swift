//
//  InfoQResponseSerializer.swift
//  fugue
//
//  Created by njliu on 3/25/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation


class InfoQArticleListResponseSerializer : AFHTTPResponseSerializer {
    override func responseObjectForResponse(response: NSURLResponse!, data: NSData!, error: NSErrorPointer) -> AnyObject! {
        var articles = [ArticleHeader]()
        
        let document = HTMLDocument(data: data, contentTypeHeader: "text/html;charset=UTF-8")
        for articleNode in document.firstNodeMatchingSelector("ul.l.l_large").childElementNodes as [HTMLElement] {
            let articleLinkNode = articleNode.firstNodeMatchingSelector("a.lt")
            let articleSummaryNode = articleNode.firstNodeMatchingSelector("a.ld")
            
            let article = ArticleHeader()
            article.title = getArticleTitle(articleLinkNode)
            article.url = getArticleUrl(articleLinkNode)
            article.summary = getArticleSummary(articleSummaryNode)

            articles.append(article)
        }
        
        return articles
    }
    
    func getArticleTitle(articleLinkNode:HTMLElement) -> String? {
        return split(articleLinkNode.textContent) {$0 == "\n"}.first
    }
    
    func getArticleUrl(articleLinkNode:HTMLElement) -> String {
        return articleLinkNode.objectForKeyedSubscript("href") as String
    }
    
    func getArticleSummary(articleSummaryNode:HTMLElement) -> String {
        return articleSummaryNode.textContent
    }
}