//
//  ViewController.swift
//  fugue
//
//  Created by njliu on 3/24/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import UIKit

class ArticleListController: UITableViewController {
    var articles: [Article]?
    
    var articleList: ArticleListView {
        get{
            return tableView as ArticleListView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // auto-resizing row height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        // initialize table view refresh control
        refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)

        
        let repo = ArticleRepo()
        articleList.articles = repo.getAll()
        
        //loadSavedArticles()
        

        
        //let url = NSURL(string: "https://avatars3.githubusercontent.com/u/3588994?v=3&s=96")
        //let data = NSData(contentsOfURL: url!, options: nil, error: nil)
//        return
        
        
//        let x = NSURL(string: "http://www.infoq.com/cn/news/2015/03/apache-kafka-stream-data-advice")
//        HttpClient.get(x!, parameters: nil, responseSerializer: InfoQArticleResponseSerializer())
//        {
//            (articleBody: ArticleBody) -> Void in
//            //println(articleBody.content)
//        }

    }
    
    func refresh(sender:AnyObject)
    {
        let url = NSURL(string: "http://www.infoq.com/cn/news")
        downloadArticles(url) {
            (newArticle, allDone) -> Void in
            self.articleList.articles?.insert(newArticle, atIndex: 0)
            self.tableView.reloadData()
            if allDone {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    

    func downloadArticles(articleListUrl: NSURL?, gotNewArticle:(Article, Bool)->Void) {
        HttpClient.get(articleListUrl!, parameters: nil, responseSerializer: InfoQArticleListResponseSerializer()) {
            (articleHeaders: [ArticleHeader]) -> Void in
            var articleCount = 0
            for articleHeader in articleHeaders {
                if let articleUrl = NSURL(string: articleHeader.url!, relativeToURL: articleListUrl) {
                    // download article
                    HttpClient.get(articleUrl, parameters: nil, responseSerializer: InfoQArticleResponseSerializer()) {
                        (articleBody: ArticleBody) -> Void in
                        let repo = ArticleRepo()
                        let newArticle = repo.insert(articleHeader, articleBody: articleBody)
                        
                        let allDone = ++articleCount == articleHeaders.count
                        gotNewArticle(newArticle, allDone)
                    }
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let articleController = segue.destinationViewController as? ArticleController {
            articleController.article = articleList.selectedArticle
        }
    }
    
    @IBAction func tapTrashButtonItem(sender: UIBarButtonItem) {
        let repo = ArticleRepo()
        repo.deleteAll()
        articleList.articles = repo.getAll()
        self.articleList.reloadData()
    }
    
}

