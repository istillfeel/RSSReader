//
//  News.swift
//  RSSReader
//
//  Created by Daria on 06.08.17.
//  Copyright © 2017 Daria. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class News: Object, Mappable {
    
    dynamic var status = ""
    dynamic var source = ""
    dynamic var sortBy = ""
    var articles = List<Article>()
    
    override static func primaryKey() -> String? {
        return "source"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        source <- map["source"]
        sortBy <- map["sortBy"]
        if let articlesData =  map["articles"].currentValue as? [[String: Any]] {
            articles.append(contentsOf: Mapper<Article>().mapArray(JSONArray: articlesData))
        }
    }
    
}

class Article: Object, Mappable {
    
    dynamic var author = ""
    dynamic var title = ""
    dynamic var descriptionNews = ""
    dynamic var url = ""
    dynamic var urlToImage = ""
    dynamic var publishedAt = ""
    
    override static func primaryKey() -> String? {
        return "author"
    }
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        author <- map["author"]
        title <- map["title"]
        descriptionNews <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
    }
}
