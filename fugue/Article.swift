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
    @NSManaged var publishAt: NSDate?
    
    func set(#header: ArticleHeader, body: ArticleBody) {
        self.title = header.title
        self.url = header.url
        self.summary = header.summary
        self.author = header.author
        self.content = body.content
        self.publishAt = header.publishAt
    }

//    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
//        super.init(entity: entity, insertIntoManagedObjectContext: context)
//        
//    }
    
}
