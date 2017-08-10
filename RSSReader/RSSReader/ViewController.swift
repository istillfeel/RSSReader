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
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let url = "https://newsapi.org/v1/articles?source=bbc-sport&sortBy=top&apiKey=2f6537187ab544e4bc9be28a00ffb384"
    
    var articles = List<Article>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        DispatchQueue.global().async {
            
            Alamofire.request(self.url).responseObject { [weak self] (response: DataResponse<News>) in
                
                guard let articles = response.result.value?.articles else {
                    //если по какой-то причине данные не загрузились
                    self?.activityIndicator.stopAnimating()
                    let alert = UIAlertController(title: "Error", message: "Error when loading news", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                    return
                }
                
                print(articles)
                
                do {
                    let realm = try Realm()
                    try realm.write {
                        articles.forEach { realm.add($0, update: true) }
                    }
                } catch let error as NSError {
                    print(error)
                }
                
                // если все ок загрузилось
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.performSegue(withIdentifier: "OpenTableView", sender: articles)
                }
            }
            
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenTableView" {
            
        }
    }
    
}

