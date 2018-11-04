//
//  ViewController.swift
//  NewsFeed
//
//  Created by Lucas Dahl on 10/31/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Properties
    var model = ArticleModel()
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Confrom to the tableview protocols
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get the articles from the article model
        model.delegate = self
        model.getArticles()
        
    }
    
    // Segue properties
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the article which the user tapped
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            print("User didn't select an article")
            return
        }
        
        let article = articles[indexPath!.row]
        
        // Get a reference to the DetialViewController
        let detailVC = segue.destination as! DetailViewController
        
        // Set the articleUrl property of the DetailViewController
        detailVC.articleUrl = article.url
        
    }

} // End class

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of articles
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // Get article that the tableview is trying to display
        let article = articles[indexPath.row]
        
        // TODO: Customize it
        cell.displayArticle(article)
        
        // Return that cell
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Transition to the detail view and pass the article that was selected
        
    }
    
}

extension ViewController: ArticleModelProtocol {
    
    func artilcesRetrieved(_ articles: [Article]) {
        self.articles = articles
        tableView.reloadData()
    }
    
}

