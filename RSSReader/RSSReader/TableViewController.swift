//
//  TableViewController.swift
//  RSSReader
//
//  Created by Daria on 06.08.17.
//  Copyright © 2017 Daria. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let reuseIdentifier = "Cell"
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
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
        cell.dateLabel.text = articles[indexPath.row].publishedAt
        cell.descriptionLabel.text = articles[indexPath.row].description

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
