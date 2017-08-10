//
//  DetailsViewController.swift
//  RSSReader
//
//  Created by Daria on 07.08.17.
//  Copyright © 2017 Daria. All rights reserved.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var article: Article?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .white
        updateUI()
        //setupWebView()
    }

    func updateUI() {
        titleLabel.text = article?.title
        authorLabel.text = article?.author
        newsTextView.text = article?.descriptionNews
        imageView.loadImageUsingUrlString(urlString: (article?.urlToImage)!)
        
        guard let dateString = article?.publishedAt else {
            return
        }
        
        dateLabel.text = dateString.convertDate()
    }
    
    
    @IBAction func openSafariViewController(_ sender: UIButton) {
        let url = URL(string: (article?.url)!)
        let svc = SFSafariViewController(url: url!)
        self.present(svc, animated: true, completion: nil)
    }
    
}

