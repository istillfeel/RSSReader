//
//  CustomTableViewCell.swift
//  RSSReader
//
//  Created by Daria on 06.08.17.
//  Copyright © 2017 Daria. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let icon: CustomImageView = {
        let iv = CustomImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.lineBreakMode = .byWordWrapping
        lb.numberOfLines = 0
        
        return lb
    }()
    
    let authorLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .lightGray
        lb.textAlignment = .left
        
        return lb
    }()
    
    let dateLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .lightGray
        lb.textAlignment = .right
        
        return lb
    }()
    
    let descriptionLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.lineBreakMode = .byWordWrapping
        lb.numberOfLines = 0
        
        return lb
    }()
    
    func setupCell() {
        addSubview(icon)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(dateLabel)
        addSubview(descriptionLabel)
        
        icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 36).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: icon.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: -8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -4).isActive = true
        authorLabel.widthAnchor.constraint(equalToConstant: titleLabel.frame.width / 2).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: authorLabel.topAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: titleLabel.frame.width / 2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: icon.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: -8).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8).isActive = true
    }

}

class CustomImageView: UIImageView {
    
    let imageCache = NSCache<NSString, UIImage>()
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        image = nil // чтобы каждый раз картинка удалялась
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {[unowned self] in
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                self.imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                
                
            }
            
        }).resume()
    }
}

