//
//  TableViewController.swift
//  RSSReader
//
//  Created by Daria on 06.08.17.
//  Copyright © 2017 Daria. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
    
    let reuseIdentifier = "Cell"
    var articles: Results<Article>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        getArticlesFormDataBase()
    }
    
    func getArticlesFormDataBase() {
        do {
            let realm = try Realm()
            articles = realm.objects(Article.self)
            
            print(articles.count)
            
            self.tableView.reloadData()
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CustomTableViewCell
        
        cell.titleLabel.text = articles[indexPath.row].title
        cell.authorLabel.text = articles[indexPath.row].author
        cell.descriptionLabel.text = articles[indexPath.row].descriptionNews
        cell.icon.loadImageUsingUrlString(urlString: articles[indexPath.row].urlToImage)
        cell.dateLabel.text = articles[indexPath.row].publishedAt.convertDate()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descriptionHeight = self.heightOfLabel(articles[indexPath.row].descriptionNews, view: self.view)
        
        return 84 + descriptionHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        self.performSegue(withIdentifier: "toDetailVC", sender: article)
    }
    
    // динамическая высота ячейки
    func heightOfLabel(_ text: String, view: UIView) -> CGFloat {
        
        let size = CGSize(width: view.frame.width - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        
        return rectangleHeight
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC",
            let destinationViewController = segue.destination as? DetailsViewController,
            let article = sender as? Article {
            
            destinationViewController.article = article
        }
    }
}


