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
        let html = document.firstNodeMatchingSelector("div.news_item_content").innerHTML
        return encodeImage(html).trim()
    }
    
    func getAuthor(document: HTMLDocument) -> String {
        return document.firstNodeMatchingSelector("p.heading_author").textContent
            .stringByReplacingOccurrencesOfString("\\s", withString: "", options: NSStringCompareOptions.RegularExpressionSearch)
            .trim()
    }
    
    func encodeImage(html: String) -> String {
        var encodedHtml = html
        let pattern = "<img\\s+.*?src=\"(.*?)\".*?/>"
        let regex = Regex(pattern)
        for m in regex.matches(html).reverse() {
            let imgRange = m.rangeAtIndex(0)
            let imgUrlRange = m.rangeAtIndex(1)

            let imgUrl = (html as NSString).substringWithRange(imgUrlRange)
            let imgFragment = createImageFragment(imgUrl)
            
            encodedHtml = (encodedHtml as NSString).stringByReplacingCharactersInRange(imgRange, withString: imgFragment)
        }
        //print(encodedHtml)
        return encodedHtml
    }
    
    func createImageFragment(url: String) -> String {
        //let data = NSData(contentsOfURL: url!, options: nil, error: nil)
        let request = NSURLRequest(URL: NSURL(string: url)!)
        var response: NSURLResponse?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil)?
            .base64EncodedStringWithOptions(.allZeros)
        let httpResponse = response as? NSHTTPURLResponse
        let contentType = httpResponse?.allHeaderFields["Content-Type"] as? String
        // data:image/png;base64,iVBOR...
        return "<img src=\"data:\(contentType!);base64,\(data!)\" />"
    }
}
