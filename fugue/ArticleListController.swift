//
//  ViewController.swift
//  fugue
//
//  Created by njliu on 3/24/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import UIKit

class ArticleListController: UIViewController {

    @IBOutlet weak var articleList: ArticleListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //loadSavedArticles()
        
        let url = NSURL(string: "http://www.infoq.com/cn/news")
        //downloadArticles(url)
        
        let img = HTMLElement(tagName: "img", attributes: ["src": "updog.png"])
        println(img.serializedFragment)
        return
        
//        let x = NSURL(string: "http://www.infoq.com/cn/news/2015/03/apache-kafka-stream-data-advice")
//        self.downloadArticleBody(x, success: { (articleBody) -> Void in
//            //self.saveArticle(articleHeader, articleBody: articleBody)
//        })

    }
    
    func loadSavedArticles() {
        let repo = ArticleRepo()
        let articles = repo.getAll()
        articleList.articles = articles
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
                for articleHeader in responseObject as [ArticleHeader] {
                    let articleUrl = NSURL(string: articleHeader.url!, relativeToURL: articleListUrl)
                    //self.downloadArticleBody(articleUrl)
                    self.downloadArticleBody(articleUrl, success: { (articleBody) -> Void in
                        self.saveArticle(articleHeader, articleBody: articleBody)
                    })
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                NSLog(error.localizedDescription)
        })
    }
    
    func downloadArticleBody(articleUrl:NSURL?, success:(ArticleBody)->Void) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = InfoQArticleResponseSerializer()
        //manager.requestSerializer.setValue("text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", forHTTPHeaderField: "Accept")
        manager.GET(articleUrl?.absoluteString,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                let articleBody = responseObject as ArticleBody
                success(articleBody)
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                NSLog(error.localizedDescription)
        })
    }
    
    func saveArticle(articleHader: ArticleHeader, articleBody: ArticleBody) {
        NSLog("Saving \(articleHader.title)")
        let repo = ArticleRepo()
        repo.insert(articleHader, articleBody: articleBody)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let articleController = segue.destinationViewController as? ArticleController {
            articleController.article = articleList.getSelectedArticle()
        }
    }
}

