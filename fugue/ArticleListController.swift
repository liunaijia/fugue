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
        
//        loadSavedArticles()
        
        //let url = NSURL(string: "http://www.infoq.com/cn/news")
        //downloadArticles(url)
        
        let x = NSURL(string: "http://www.infoq.com/cn/news/2015/03/apache-kafka-stream-data-advice")
        HttpClient.get(x!, parameters: nil, responseSerializer: InfoQArticleResponseSerializer())
        {
            (articleBody: ArticleBody) -> Void in
            println(articleBody.author)
        }

    }
    
    func loadSavedArticles() {
        let repo = ArticleRepo()
        let articles = repo.getAll()
        articleList.articles = articles
    }

    func downloadArticles(articleListUrl: NSURL?) {
        HttpClient.get(articleListUrl!, parameters: nil, responseSerializer: InfoQArticleListResponseSerializer()) {
            (articleHeaders: [ArticleHeader]) -> Void in
            for articleHeader in articleHeaders {
                if let articleUrl = NSURL(string: articleHeader.url!, relativeToURL: articleListUrl) {
                    // download article
                    HttpClient.get(articleUrl, parameters: nil, responseSerializer: InfoQArticleResponseSerializer())
                        {self.saveArticle(articleHeader, articleBody: $0)}
                }
            }
        }
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

