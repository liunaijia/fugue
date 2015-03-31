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
    }
    
//    override func numberOfSections() -> Int {
//        return 1
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles != nil ? articles!.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.dequeueReusableCellWithIdentifier("article") as UITableViewCell
        let article = articles?[indexPath.row]
        cell.textLabel?.text = article?.title
        cell.detailTextLabel?.text = article?.summary
        return cell
    }
    
}