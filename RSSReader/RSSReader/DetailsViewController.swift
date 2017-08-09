//
//  DetailsViewController.swift
//  RSSReader
//
//  Created by Daria on 07.08.17.
//  Copyright © 2017 Daria. All rights reserved.
//

import UIKit

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
        newsTextView.text = article?.description
        imageView.loadImageUsingUrlString(urlString: (article?.urlToImage)!)
        
        guard let dateString = article?.publishedAt else {
            return
        }
        
        dateLabel.text = dateString.convertDate()
    }
    
//    func setupWebView() {
//        let webview = UIWebView()
//        webview.delegate = self
//        
//        let url = URL(string: (article?.url)!)
//        webview.loadRequest(URLRequest(url: url!))
//    }
//
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        if let textContent = webView.stringByEvaluatingJavaScript(from: "document.body.innerText") {
//            print(textContent)
//        }
//    }
}

