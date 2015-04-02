//
//  ArticleRepo.swift
//  fugue
//
//  Created by njliu on 3/30/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation
import CoreData

class ArticleRepo {
    lazy var managedObjectContext : NSManagedObjectContext = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.managedObjectContext!
    }()
    
    func insert(articleHeader: ArticleHeader, articleBody: ArticleBody) -> Article {
        let article = NSEntityDescription.insertNewObjectForEntityForName("Article", inManagedObjectContext: self.managedObjectContext) as Article
        article.set(articleHeader, articleBody: articleBody)
        
        managedObjectContext.save()
        
        return article
    }
    
    func getAll() -> [Article]? {
        var error: NSError?
        let fetchRequest = NSFetchRequest(entityName:"Article")
        let fetchedResults = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as [Article]?
        return fetchedResults
//        if let results = fetchedResults {
//            return results
//        } else {
//            println("Could not fetch \(error), \(error!.userInfo)")
//        }
    }
    
    func deleteAll() {
        if let articles = getAll() {
            for article in articles {
                managedObjectContext.deleteObject(article)
            }
            managedObjectContext.save()
        }
    }
}
