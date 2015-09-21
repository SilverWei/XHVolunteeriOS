//
//  PtrResponse.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-22.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation

class PtrResponse : NSObject {
    var updatedata = [PtrUpdaeData]()
    var TotalCount:Int
    var Guid:String
    init(updatedata:[PtrUpdaeData],TotalCount:Int,Guid:String)
    {
        self.updatedata = updatedata
        self.TotalCount = TotalCount
        self.Guid = Guid
    }
}
