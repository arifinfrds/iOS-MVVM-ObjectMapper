//
//  CommentsViewModel.swift
//  Test DOT iOS Arifin Firdaus
//
//  Created by Arifin Firdaus on 6/16/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import Foundation

class CommentsViewModel {
    
    
    // MARK: - Properties
    
    var comments: [Comment] = []
    var error: Error?
    var refreshing = false
    
    private var dataService: DataService?
    
    
    // MARK: - Object Life Cycle
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    
    // MARK: - Networking logic
    
    func fetchComments(withPostId postId: Int, completion: @escaping (Bool, Error?) -> ()) {
        dataService?.requestFetchComments(withPostId: postId, completion: { (comments, error) in
            if let error = error {
                self.error = error
                self.refreshing = false
                self.comments = []
                completion(false, error)
            }
            if let items = comments {
                self.comments = items
                self.refreshing = false
                self.error = nil
                completion(true, nil)
            }
            
        })
    }
    
    
    // MARK: - Presentation logic
    // ...
    // MARK: - Bussiness logic
    // ...
}
