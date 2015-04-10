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
            
            
            let article = ArticleHeader()
            article.title = getArticleTitle(articleLinkNode)
            article.url = getArticleUrl(articleLinkNode)
            article.summary = getArticleSummary(articleNode)
            article.author = getAuthor(articleNode)
            article.publishAt = getPublishDate(articleNode)
            articles.append(article)
        }
        
        return articles
    }
    
    func getArticleTitle(articleLinkNode:HTMLElement) -> String? {
        return (split(articleLinkNode.textContent) {$0 == "\n"}.first)?.trim()
    }
    
    func getArticleUrl(articleLinkNode:HTMLElement) -> String {
        return (articleLinkNode.objectForKeyedSubscript("href") as String).trim()
    }
    
    func getArticleSummary(articleNode:HTMLElement) -> String {
        let articleSummaryNode = articleNode.firstNodeMatchingSelector("a.ld")
        return articleSummaryNode.textContent.trim()
    }
    
    func getAuthor(articleNode:HTMLElement) -> String {
        let authorNode = articleNode.firstNodeMatchingSelector("span.ls a")
        return authorNode.textContent.trim()
    }
    
    func getPublishDate(articleNode: HTMLElement) -> NSDate? {
        let dateNode = articleNode.firstNodeMatchingSelector("ul.ldate")
        if let year = dateNode.firstNodeMatchingSelector("li.ldate_y").textContent.toInt() {
            if let month = parseMonth(dateNode.firstNodeMatchingSelector("li.ldate_d").textContent) {
                if let day = dateNode.firstNodeMatchingSelector("li.ldate_m").textContent.toInt() {
                    return NSDate.from(year: year, month: month, day: day)
                }
            }
        }
        
        return nil
    }
    
    func parseMonth(str: String) -> Int? {
        let months:[String] = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
        for (index, month) in enumerate(months) {
            if month == str {
                return index + 1
            }
        }
        return nil
    }
}