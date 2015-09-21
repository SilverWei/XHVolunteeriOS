//
//  Ptr.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-22.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation

class PtrRequest: NSObject {
    var Skip:Int //需要跳过的数据数量
    var Count:Int    //需要获取的数据数量
    var LocalData:PtrUpdateParam //需要更新的数据
    var Guid:String //唯一区分当前请求
    
    init(Skip:Int, Count:Int, LocalData:PtrUpdateParam, Guid:String) {
        self.Skip = Skip
        self.Count = Count
        self.LocalData = LocalData
        self.Guid = Guid
    }
}

//需要更新的请求参数
class PtrUpdateParam: NSObject {
    var Id:Int?
    var IndexId:Int?
    var Tick:Int?
    
    init(Id:Int?, IndexId:Int?, Tick:Int?) {
        self.Id = Id
        self.IndexId = IndexId
        self.Tick = Tick
    }
}