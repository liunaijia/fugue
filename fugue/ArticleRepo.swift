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
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext!
    }()
    
    func insert(#header: ArticleHeader, body: ArticleBody) -> Article {
        let article = NSEntityDescription.insertNewObjectForEntityForName("Article", inManagedObjectContext: self.managedObjectContext) as! Article
        article.set(header: header, body: body)
        
        managedObjectContext.save()
        
        return article
    }
    
    func getAll() -> [Article]? {
        var error: NSError?
        let fetchRequest = NSFetchRequest(entityName:"Article")
        let fetchedResults = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as! [Article]?
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
    
    func getLatestPublishDate() -> NSDate? {
        let expression = NSExpressionDescription()
        expression.name = "maxPublishDate"
        expression.expression = NSExpression(forFunction: "max:", arguments: [NSExpression(forKeyPath: "publishAt")])
        expression.expressionResultType = NSAttributeType.DateAttributeType
        
        let request = NSFetchRequest(entityName: "Article")
        request.resultType = NSFetchRequestResultType.DictionaryResultType
        request.propertiesToFetch = [expression]

        if let results = managedObjectContext.executeFetchRequest(request, error: nil) as? [Dictionary<String, AnyObject>] {
            if let result = results.first {
                return result["maxPublishDate"] as? NSDate
            }
        }
        
        return .None
    }
}
