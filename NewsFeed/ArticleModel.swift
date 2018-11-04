//
//  ArticleModel.swift
//  NewsFeed
//
//  Created by Lucas Dahl on 10/31/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation

protocol ArticleModelProtocol {
   
    func artilcesRetrieved(_ articles:[Article])
    
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        
        // Create a string URL -- You will need your own API Key to make this work
        // Article API Website -- https://newsapi.org
        let stringUrl = "" // API Key goes here.
        
        // Create a URL object
        let url = URL(string: stringUrl)
        
        // Check that it isn't nill
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        // Get the URL Session
        let session = URLSession.shared
        
        // Create the DataTask object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check if there is no error and if there is data
            if error == nil && data != nil {
                
                do {
                    
                    // Decode the json data into our structs
                    let decoder = JSONDecoder()
                    
                    let result = try decoder.decode(ArtilceService.self, from: data!)
                    
                    // Pass the articles back to the new view controller
                    let articles = result.articles!
                    
                    // Do this on the main thread
                    DispatchQueue.main.sync {
                        self.delegate?.artilcesRetrieved(articles)
                    }
                    
                } catch {
                    
                    print("Couldnt decode the json: \(error)")
                    return
                    
                }// End Catch
            } // End if
            
        } // End dataTask
        
        //  Resume the task to fire off the request to the API
        dataTask.resume()
    }// End GetArticles
    
} // End ArticlModel
