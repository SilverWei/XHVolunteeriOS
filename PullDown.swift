//
//  PullDown.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-15.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation

class PullDownRequest: NSObject {
    var ptrRequest:PtrRequest
    var request:RequestType
    
    init(ptrRequest:PtrRequest, request:RequestType) {
        self.ptrRequest = ptrRequest
        self.request = request
    }
}


class PullDownResult: NSObject {
    var PtrRequest:ResultType?
    var ErrorMsg:String
    
    init(PtrRequest:ResultType?,ErrorMsg:String) {
        self.PtrRequest = PtrRequest
        self.ErrorMsg = ErrorMsg
    }
}

enum ResultType:Int
{
    case Success = 0
    case Error = 1
}

enum RequestType:Int
{
    case Mine = 0
    case Manager = 1
    case Finish = 2
    case Leave = 3
    case All = 4
}


