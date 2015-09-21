//
//  ActivityDB.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-22.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation

class ActivityDB: NSObject {
    var IndexId:Int //序号
    var ActivityName:String
    var TeamName:String //组别名称
    var UserName:String //发布者用户名称
    var ActivityStartTime:String //活动开始时间
    var ActivityEndTime:String //活动结束时间
    var ActivityLocation:String //活动举行地点
    var ActivitySummary:String //活动简介
    var ActivityState:String //活动状态
    var ActivityAttend:Int //参加人数
    var JoinCount:Int //以报人数
    var Tick:Int //时间戳
    var IsJoining:Bool //是否开放
    var Id:Int

    
    init(IndexId:Int, ActivityName:String, TeamName:String, UserName:String, ActivityStartTime:String, ActivityEndTime:String, ActivityLocation:String, ActivitySummary:String, ActivityState:String, ActivityAttend:Int, JoinCount:Int, Tick:Int, IsJoining:Bool, Id:Int)
    {
        self.IndexId = IndexId
        self.ActivityName = ActivityName
        self.TeamName = TeamName
        self.UserName = UserName
        self.ActivityStartTime = ActivityStartTime
        self.ActivityEndTime = ActivityEndTime
        self.ActivityLocation = ActivityLocation
        self.ActivitySummary = ActivitySummary
        self.ActivityState = ActivityState
        self.ActivityAttend = ActivityAttend
        self.JoinCount = JoinCount
        self.Tick = Tick
        self.IsJoining = IsJoining
        self.Id = Id
    }
}