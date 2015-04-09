//
//  Comment.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class Comment: NSObject {
    var user : User?
    var date : Int?
    var time : Int?
    var content : String?
}

extension Comment{
    func toPFObject() -> PFObject{
        var object = PFObject(className: "Comment")
        
        if let user = self.user{
            object["user"] = user
        }
        if let date = self.date{
            object["date"] = date
        }
        if let time = self.time{
            object["time"] = time
        }
        if let content = self.content{
            object["content"] = content
        }
        
        return object
    }
}