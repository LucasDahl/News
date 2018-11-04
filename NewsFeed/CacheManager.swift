//
//  CacheManager.swift
//  NewsFeed
//
//  Created by Lucas Dahl on 11/2/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation

class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveImageData(_ url:String, _ data:Data) {
        
        // Saving the image data to our image dictionary
        imageDictionary[url] = data
        
    }
    
    static func retrieveImageData(_ url:String) -> Data? {
    
        // Try to retrieve the value for the key that's passed onto this method
        return imageDictionary[url]
        
    }
    
}
