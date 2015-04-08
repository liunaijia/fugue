//
//  ArticleListViewCell.swift
//  fugue
//
//  Created by njliu on 3/31/15.
//  Copyright (c) 2015 Naijia Liu. All rights reserved.
//

import Foundation

class ArticleListViewCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func set(article:Article?) {
        titleLabel.text = article?.title
        subTitleLabel.text = article?.author
    }
}