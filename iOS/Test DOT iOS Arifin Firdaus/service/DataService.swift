//
//  DataManager.swift
//  Test DOT iOS Arifin Firdaus
//
//  Created by Arifin Firdaus on 6/17/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct DataService {
    
    
    // MARK: - Url
    
    private static let baseUrl = "https://jsonplaceholder.typicode.com"
    
    private static let PostsUrl = "\(DataService.baseUrl)/posts"
    
    private static func getPostUrl(withId id: Int) -> String {
        return "\(DataService.baseUrl)/posts"
    }
    
    private static func getCommentsUrl(withId id: Int) -> String {
        return "\(DataService.baseUrl)/posts/\(id)/comments"
    }
    
    
    // MARK: - Post Service
    
    func requestFetchPosts(completion: @escaping (Posts?, Error?) -> ()) {
        Alamofire.request(DataService.PostsUrl).responseJSON { response in
            print("DataService: requestFetchPosts: Request: \(String(describing: response.request))")   // original url request
            print("DataService: requestFetchPosts: Response: \(String(describing: response.response))") // http url response
            print("DataService: requestFetchPosts: Result: \(response.result)")                         // response serialization result
            if let error = response.error {
                print("DataService: fetchPosts: error: \(error.localizedDescription)")
                completion(nil, error)
            }
            if let json = response.result.value {
                let posts = Mapper<Post>().mapArray(JSONObject: json)
                completion(posts, nil)
            }
        }
    }
    
    
    // MARK: - Comments Service
    
    func requestFetchComments(withPostId postId: Int, completion: @escaping (Comments?, Error?) -> ()) {
        Alamofire.request(DataService.getCommentsUrl(withId: postId)).responseJSON { response in
            if let error = response.error {
                print("DataService: requestFetchComments: error: \(error.localizedDescription)")
                completion(nil, error)
            }
            if let json = response.result.value {
                let comments = Mapper<Comment>().mapArray(JSONObject: json)
                completion(comments, nil)
            }
        }
    }
    
    
}
