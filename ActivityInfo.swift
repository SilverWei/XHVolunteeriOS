//
//  ActivityInfo.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-14.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation

class ActivityInfos: NSObject {
    var IndexId:Int
    var ActivityID:String
    var ActivityName:String
    var TeamName:String
    var UserName:String
    var ActivityStartTime:String
    var ActivityEndTime:String
    var ActivityLocation:String
    var ActivitySummary:String
    var ActivityState:String
    var ActivityAttend:Int
    var JoinCount:Int
    var Tick:Int
    var IsJoining:Bool
    
    /**
    ActivityInfo
    
    :param: IndexId           序号
    :param: ActivityID        活动管理号
    :param: ActivityName
    :param: TeamName          组别名称
    :param: UserName          发布者用户名称
    :param: ActivityStartTime 活动开始时间
    :param: ActivityEndTime   活动结束时间
    :param: ActivityLocation  活动举行地点
    :param: ActivitySummary   活动简介
    :param: ActivityState     活动状态
    :param: ActivityAttend    参加人数
    :param: JoinCount         以报人数
    :param: Tick              时间戳
    :param: IsJoining         是否开放
    
    :returns:
    */
    init(IndexId:Int, ActivityID:String, ActivityName:String, TeamName:String, UserName:String, ActivityStartTime:String, ActivityEndTime:String, ActivityLocation:String, ActivitySummary:String, ActivityState:String, ActivityAttend:Int, JoinCount:Int, Tick:Int, IsJoining:Bool)
    {
        self.IndexId = IndexId
        self.ActivityID = ActivityID
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
    }
}