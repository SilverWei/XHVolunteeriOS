//
//  GetUserInfo.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-15.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation

class InfoIn: NSObject {
    var UserId:String
    
    init(UserId:String)
    {
        self.UserId = UserId
    }
}

class InfoOut: NSObject {
    var UserID:String
    var UserName:String
    var UserRole:String
    var PhoneNumber:String
    var TeamName:String
    var QQNumber:String
    var PersonalInfo:String
    var ActivityLong:String
    var Sex:Bool
    var Tick:Int
    var UserPicture:String

    init(UserID:String, UserName:String, UserRole:String, PhoneNumber:String, TeamName:String, QQNumber:String, PersonalInfo:String, ActivityLong:String, Sex:Bool, Tick:Int, UserPicture:String)
    {
        self.UserID = UserID
        self.UserName = UserName
        self.UserRole = UserRole
        self.PhoneNumber = PhoneNumber
        self.TeamName = TeamName
        self.QQNumber = QQNumber
        self.PersonalInfo = PersonalInfo
        self.ActivityLong = ActivityLong
        self.Sex = Sex
        self.Tick = Tick
        self.UserPicture = UserPicture
    }
}