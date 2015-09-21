//
//  PtrUpdateData.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-22.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation
class PtrUpdaeData: NSObject {
    var Type:UpdateType
    var Data:ActivityDB
    
    init(Type:UpdateType ,Data:ActivityDB){
        self.Type = Type
        self.Data = Data
    }
}