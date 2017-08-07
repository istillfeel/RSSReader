//
//  News.swift
//  RSSReader
//
//  Created by Daria on 06.08.17.
//  Copyright © 2017 Daria. All rights reserved.
//

import Foundation
import ObjectMapper

class News: Mappable {
    
    var status: String?
    var source: String?
    var sortBy: String?
    var articles: [Article]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        source <- map["source"]
        sortBy <- map["sortBy"]
        articles <- map["articles"]
    }
    
}

class Article : Mappable {
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
    }
}
