//
//  ArticleCell.swift
//  NewsFeed
//
//  Created by Lucas Dahl on 11/2/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    // Properties
    var articleToDisplay:Article?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayArticle(_ article:Article) {
        
        // Set label and imageview to invisible
        headlineLabel.alpha = 0
        articleImageView.alpha = 0
        
        // Animate the headline label
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            
            self.headlineLabel.alpha = 1
            
        }, completion: nil)
        
        // Clear the imageview (incase the cell is being reused)
        articleImageView.image = nil
        
        // Hold the reference to the article
        articleToDisplay = article
        
        // Display rhe headline
        headlineLabel.text = articleToDisplay!.title!
        
        // Download article image
        
        // check if the article has an image
        let urlString = articleToDisplay!.urlToImage
        
        guard urlString != nil else {
            return
        }
        
        // Before we go and download the image, check if it's in the cache
        let cachedData = CacheManager.retrieveImageData(urlString!)
        
        if cachedData != nil {
            // If the cached data exists, use that instead
            articleImageView.image = UIImage(data: cachedData!)
            
            // Animates the article image in
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.articleImageView.alpha = 1
                
            }, completion: nil)
            
            return
        }
        
        // Create url object
        let url = URL(string: urlString!)
        
        // Check that it isnt nil
        guard url != nil else {
            print("couldnt create url object")
            return
        }
        
        // Get the session
        let session = URLSession.shared
        
        // Creat the data task
        let dataTask = session.dataTask(with: url!) { (data, responce, error) in
            
            // Check that there's no error and that there is data
            if error == nil && data != nil {
                
                // Save the image data to cache
                CacheManager.saveImageData(urlString!, data!)
                
                // Before image is set, ensure that the image is data is still relevant to the artilce.
                if self.articleToDisplay?.urlToImage == urlString! {
                    
                    // Set the imageview with the data
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data: data!)
                        
                        // Animate the image ine
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.articleImageView.alpha = 1
                            
                        }, completion: nil)
                    }
                    
                } // End if
            } // End if
        } // End datatask
        
        // Fire the datatask
        dataTask.resume()
        
    }
    
}
