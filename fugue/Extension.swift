//
//  Extension.swift
//  fugue
//
//  Created by njliu on 3/31/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation
import CoreData

extension String {
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}

extension NSURLResponse {
    var contentType: String? {
        get{
            if let httpResponse = self as? NSHTTPURLResponse {
                let contentType = httpResponse.allHeaderFields["Content-Type"] as? String
                return contentType
            }
            return nil
        }
    }
}

extension NSManagedObjectContext {
    func save() {
        var error: NSError?
        if !self.save(&error) {
            NSLog("Could not save \(error), \(error?.userInfo)")
        }
    }
}

extension NSDate {
    
    /// Returns a new Date given the year month and day
    ///
    /// :param year
    /// :param month
    /// :param day
    /// :return Date
    public class func from(#year: Int, month: Int, day: Int) -> NSDate? {
        var c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        
        if let gregorian = NSCalendar(identifier:NSCalendarIdentifierGregorian) {
            return gregorian.dateFromComponents(c)
        } else {
            return .None
        }
    }
}