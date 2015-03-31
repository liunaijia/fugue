//
//  Article.swift
//  fugue
//
//  Created by njliu on 3/30/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation
import CoreData

class Article: NSManagedObject {

    @NSManaged var title: String?
    @NSManaged var author: String?
    @NSManaged var url: String?
    @NSManaged var summary: String?
    @NSManaged var content: String?
    
    func set(articleHeader: ArticleHeader, articleBody: ArticleBody) {
        self.title = articleHeader.title
        self.url = articleHeader.url
        self.summary = articleHeader.summary
        self.author = articleBody.author
        self.content = articleBody.content
    }

//    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
//        super.init(entity: entity, insertIntoManagedObjectContext: context)
//        
//    }
    
}
