//
//  Article.swift
//  NewsFeed
//
//  Created by Lucas Dahl on 10/31/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation

struct Article: Decodable {
    
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    
}
