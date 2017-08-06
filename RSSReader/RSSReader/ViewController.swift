//
//  ViewController.swift
//  RSSReader
//
//  Created by Daria on 06.08.17.
//  Copyright © 2017 Daria. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireRSSParser

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        DispatchQueue.global().async {
            RSSParser.getRSSFeedResponse(path: "https://meduza.io/rss/all") { (rssFeed: RSSFeed?, status: NetworkResponseStatus) in
                print("\n", rssFeed!)
            }
            
            DispatchQueue.main.async(execute: {
                Timer.scheduledTimer(withTimeInterval: 3,
                                     repeats: false) {
                                        timer in
                                        self.activityIndicator.stopAnimating()
                }
            })
        }
        
    }

    

}


