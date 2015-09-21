//
//  EditUserInfo.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-15.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation

class EditIn: NSObject {
    var PhoneNumber:String
    var QQNumber:String
    var PersonalInfo:String
    var Sex:Bool
    
    init(PhoneNumber:String, QQNumber:String, PersonalInfo:String, Sex:Bool) {
        self.PhoneNumber = PhoneNumber
        self.QQNumber = QQNumber
        self.PersonalInfo = PersonalInfo
        self.Sex = Sex
    }
}

class EditOut: NSObject {
    var PhoneNumber:String
    var QQNumber:String
    var PersonalInfo:String
    var Sex:Bool
    
    init(PhoneNumber:String, QQNumber:String, PersonalInfo:String, Sex:Bool) {
        self.PhoneNumber = PhoneNumber
        self.QQNumber = QQNumber
        self.PersonalInfo = PersonalInfo
        self.Sex = Sex
    }
}