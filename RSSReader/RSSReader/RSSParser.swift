//
//  RSSParser.swift
//  RSSReader
//
//  Created by Daria on 06.08.17.
//  Copyright © 2017 Daria. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireRSSParser

public enum NetworkResponseStatus {
    case success
    case error(string: String?)
}

public class RSSParser {
    public static func getRSSFeedResponse(path: String, completionHandler: @escaping (_ response: RSSFeed?,_ status: NetworkResponseStatus) -> Void) {
        Alamofire.request(path).responseRSS() { response in
            if let rssFeedXML = response.result.value {
                // Successful response - process the feed in your completion handler
                completionHandler(rssFeedXML, .success)
            } else {
                // There was an error, so feel free to handle it in your completion handler
                completionHandler(nil, .error(string: response.result.error?.localizedDescription))
            }
        }
    }
}

