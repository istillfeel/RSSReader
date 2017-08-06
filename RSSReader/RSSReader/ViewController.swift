//
//  ViewController.swift
//  RSSReader
//
//  Created by Daria on 06.08.17.
//  Copyright © 2017 Daria. All rights reserved.
//
//  News API are presented by https://newsapi.org

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let url = "https://newsapi.org/v1/articles?source=bbc-sport&sortBy=top&apiKey=2f6537187ab544e4bc9be28a00ffb384"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        DispatchQueue.global().async {
            
            Alamofire.request(self.url).responseObject { (response: DataResponse<News>) in
                let news = response.result.value
                
                if let articles = news?.articles {
                    print(articles)
                }
                
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


