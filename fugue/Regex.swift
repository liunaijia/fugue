//
//  Regex.swift
//  fugue
//
//  Created by njliu on 3/31/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation

//let RegexEscapePattern = "[\\-\\[\\]\\/\\{\\}\\(\\)\\*\\+\\?\\.\\\\\\^\\$\\|]"
//let RegexPatternRegex = Regex(RegexEscapePattern)

public class Regex {
    
    let expression: NSRegularExpression
    let pattern: String
    
    public init(_ pattern: String) {
        self.pattern = pattern
        var error: NSError?
        self.expression = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)!
    }
    
    public func matches(testStr: String) -> [AnyObject] {
        let matches = self.expression.matchesInString(testStr, options: nil, range:NSMakeRange(0, count(testStr)))
        return matches
    }
    
//    public func rangeOfFirstMatch(testStr: String) -> NSRange {
//        return self.expression.rangeOfFirstMatchInString(testStr, options: nil, range:NSMakeRange(0, countElements(testStr)))
//    }
    
//    public func test(testStr: String) -> Bool {
//        let matches = self.matches(testStr)
//        return matches.count > 0
//    }
    
//    public class func escapeStr(str: String) -> String {
//        let matches = RegexPatternRegex.matches(str)
//        var charArr = [Character](str)
//        var strBuilder = [Character]()
//        var i = 0
//        for match in matches {
//            let range = match.range
//            while i < range.location + range.length {
//                if i == range.location {
//                    strBuilder << "\\"
//                }
//                strBuilder << charArr[i++]
//            }
//        }
//        while i < charArr.count {
//            strBuilder << charArr[i++]
//        }
//        return String(strBuilder)
//    }
}
