//
//  PostVO.swift
//  Kabyar
//
//  Created by Win Than Htike on 11/22/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit

class PostVO: NSObject {
    
    var id : String = UUID.init().uuidString

    var title : String? = nil
    
    var desc : String? = nil
    
    var user : UserVO? = nil
    
    var createdDate : String? = String(Date().millisecondsSince1970)
    
    var updatedDate : String? = String(Date().millisecondsSince1970)
    
    public static func parseToPostVO (json : [String : AnyObject]) -> PostVO {
        
        let post = PostVO()
        post.id = json["id"] as! String
        post.title = json["title"] as? String
        post.desc = json["desc"] as? String
        post.createdDate = json["createdDate"] as? String
        post.updatedDate = json["updatedDate"] as? String
        if let user = json["user"] as? [String : Any] {
            post.user = UserVO.parseToUserVO(json: user)
        }
        return post
        
    }
    
    public static func parseToDictionary(post : PostVO) -> [String : Any] {
        
        let value = [
            "id" : post.id,
            "title" : post.title ?? "",
            "desc" : post.desc ?? "",
            "user" : UserVO.parseToDictionary(user: post.user ?? UserVO()),
            "createdDate" : Date().millisecondsSince1970,
            "updatedDate" : Date().millisecondsSince1970,
            ] as [String : Any]
        
        return value
        
    }
    
}
