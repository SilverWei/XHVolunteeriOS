//
//  Login.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-15.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation

class LoginIn: NSObject {
    var UserName:String
    var Password:String
    
    init(UserName:String, Password:String)
    {
        self.UserName = UserName
        self.Password = Password
    }
}

class LoginOut: NSObject {
    var UserID:Int
    
    init(UserID:Int)
    {
        self.UserID = UserID
    }
}