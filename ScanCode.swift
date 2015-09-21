//
//  ScanCode.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-15.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation

class ScanCodeRequest: NSObject {
    var ScanRequest:String
    
    init(ScanRequest:String) {
        self.ScanRequest = ScanRequest
    }
}

class ScanCodeResult: NSObject {
    var request:ScanType
    var Errormsg:String?
    var ActivityLong:Int
    var ActivityName:String?
    
    init(request:ScanType,Errormsg:String?,ActivityLong:Int,ActivityName:String?) {
        self.request = request
        self.Errormsg = Errormsg
        self.ActivityLong = ActivityLong
        self.ActivityName = ActivityName
    }
}

enum ScanType:Int
{
    case First = 0 //第一次扫描
    case Second = 1 //第二次
    case Error = 2 //错误
}