//
//  PostElement.swift
//  Test DOT iOS Arifin Firdaus
//
//  Created by Arifin Firdaus on 3/16/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import Foundation
import ObjectMapper

typealias Posts = [Post]

struct Post: Mappable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.userId     <- map["userId"]
        self.id         <- map["id"]
        self.title      <- map["title"]
        self.body 	    <- map["body"]
    }
    
    
}








