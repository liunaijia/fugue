//
//  ArticleListViewController.swift
//  fugue
//
//  Created by njliu on 3/30/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation

class ArticleListView: UITableView, UITableViewDataSource {
    var articles: [Article]?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles != nil ? articles!.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCellWithIdentifier("articleCell") as! ArticleListViewCell
        cell.set(articles?[indexPath.row])
        return cell
    }
    
    var selectedArticle: Article? {
        get{
            if let index = self.indexPathForSelectedRow()?.row {
                return self.articles?[index]
            }
            return nil
        }
    }
    
}