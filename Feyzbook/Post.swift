//
//  Post.swift
//  Feyzbook
//
//  Created by Feyzullah Durası on 15.05.2024.
//

import Foundation

class Post {
    
    var email: String
    var yorum : String
    var gorselUrl : String
    
    init(email: String, yorum: String, gorselUrl: String) {
        self.email = email
        self.yorum = yorum
        self.gorselUrl = gorselUrl
    }
}
