//
//  PostsViewModel.swift
//  Test DOT iOS Arifin Firdaus
//
//  Created by Arifin Firdaus on 6/16/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import Foundation

class PostsViewModel {
    
    
    // MARK: - Properties
    
    var posts: [Post] = []
    var error: Error?
    var refreshing = false
    
    private var dataService: DataService?
    
    
    // MARK: - Object Life Cycle
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    
    // MARK: - Networking logic
    
    func fetchPosts(completion: @escaping (Bool, Error?) -> ()) {
        dataService?.requestFetchPosts(completion: { (posts, error) in
            if let err = error {
                self.error = err
                self.refreshing = false
                self.posts = []
                completion(false, error)
            } else {
                self.error = nil
                self.refreshing = false
                if let items = posts {
                    self.posts = items
                    completion(true, nil)
                }
            }
        })
    }
    
    
    // MARK: - Presentation logic
    // ...
    // MARK: - Bussiness logic
    // ...
    
    
    
}
