//
//  DetailViewController.swift
//  NewsFeed
//
//  Created by Lucas Dahl on 10/31/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Properties
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Start the activity spinner
        spinner.alpha = 1
        spinner.startAnimating()
        
        // Set delegate for the webview
        webView.navigationDelegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check if there's a url, if there is, then display it
        if articleUrl != nil {
            
            // Creates the url object
            let url = URL(string: articleUrl!)
            
            // Return if url is nil
            guard url != nil else {
                return
            }
            
            // Get the request
            let request = URLRequest(url: url!)
            
            // Pass the request to the webView
            webView.load(request)
            
        }
        
        
    }

}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Remove the spinner from the view
        spinner.stopAnimating()
        spinner.alpha = 0
        
    }
    
}
