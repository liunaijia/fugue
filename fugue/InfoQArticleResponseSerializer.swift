//
//  InfoQArticleResponseSerializer.swift
//  fugue
//
//  Created by njliu on 3/30/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation

class InfoQArticleResponseSerializer : AFHTTPResponseSerializer {
    override func responseObjectForResponse(response: NSURLResponse!, data: NSData!, error: NSErrorPointer) -> AnyObject! {
        let articleBody = ArticleBody()
        
        let document = HTMLDocument(data: data, contentTypeHeader: "text/html;charset=UTF-8")
        
        articleBody.content = getContent(document)
        articleBody.author = getAuthor(document)

        return articleBody
    }
    
    func getContent(document: HTMLDocument) -> String {
        let contentElement = document.firstNodeMatchingSelector("div.news_item_content")
        encodeImage(contentElement)
        //println(contentElement.innerHTML)
        return contentElement.innerHTML
    }
    
    func getAuthor(document: HTMLDocument) -> String {
        return document.firstNodeMatchingSelector("p.heading_author").textContent
            .stringByReplacingOccurrencesOfString("\\s", withString: "", options: NSStringCompareOptions.RegularExpressionSearch)
            .trim()
    }
    
    func encodeImage(contentElement: HTMLElement) {
        for imgNode in contentElement.nodesMatchingSelector("img") as [HTMLElement] {
            let imgUrl = imgNode.objectForKeyedSubscript("src") as String
            let srcValue = createDataValue(imgUrl)
            imgNode.setObject(srcValue, forKeyedSubscript: "src")
        }
    }
    
    func createDataValue(urlString: String) -> String? {
        //let data = NSData(contentsOfURL: url!, options: nil, error: nil)
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            var response: NSURLResponse?
            if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) {
                let encodedData = data.base64EncodedStringWithOptions(.allZeros)
                if let contentType = response?.contentType {
                    // data:image/png;base64,iVBOR...
                    return "data:\(contentType);base64,\(encodedData)"
                }
            }
        }
        
        return nil
    }
}
