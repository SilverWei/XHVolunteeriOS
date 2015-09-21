//
//  IActivityReposity.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-15.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation

protocol ActivityReposity
{
    
    func GetActivityInfos(活动ID IndexId:Int, 时间戳 tick:Int) -> ActivityInfos  //获取活动详细最新信息
    func EndActivity(活动ID ActivityID:Int) -> PullDownResult //结束活动
    func GetActivitiesData(postData:PullDownRequest)  -> PtrResponse//下拉刷新确认
    func AddApply(ActivityID:Int) -> PullDownResult //参加报名
    func ScanCode(ActivityID:Int) -> ScanCodeRequest //首次刷二维码
    func TwoScanCode(ActivityID:Int) -> ScanCodeRequest //第二次刷二维码
    
}