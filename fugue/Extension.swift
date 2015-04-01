//
//  Extension.swift
//  fugue
//
//  Created by njliu on 3/31/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation

extension String {
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}

