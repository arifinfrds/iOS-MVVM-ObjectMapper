//
//  CommentElement.swift
//  Test DOT iOS Arifin Firdaus
//
//  Created by Arifin Firdaus on 3/16/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import Foundation
import ObjectMapper

typealias Comments = [Comment]

struct Comment: Mappable {
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.postId     <- map["postId"]
        self.id         <- map["id"]
        self.name       <- map["name"]
        self.email      <- map["email"]
        self.body       <- map["body"]
    }
    
}


