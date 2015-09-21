//
//  ActivityDetailCell.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-27.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit

class ActivityDetailCell: UITableView {
    @IBOutlet var IndexIdLabel: UILabel! //序号
    @IBOutlet var ActivityNameLabel: UILabel! //活动标题
    @IBOutlet var TeamNameLabel:UILabel! //组别名称
    @IBOutlet var UserNameLabel:UILabel! //发布者用户名称
    @IBOutlet var ActivityStartTimeLabel:UILabel! //活动开始时间
    @IBOutlet var ActivityEndTimeLabel:UILabel! //活动结束时间
    @IBOutlet var ActivityLocationLabel:UILabel! //活动举行地点
    @IBOutlet var ActivitySummaryLabel:UITextView! //活动简介
    @IBOutlet var ActivityStateLabel:UILabel! //活动状态
    @IBOutlet var ActivityAttendLabel:UILabel! //参加人数
    @IBOutlet var JoinCountLabel:UILabel! //以报人数
    @IBOutlet var TickLabel:UILabel! //时间戳
    @IBOutlet var IsJoiningLabel:UILabel! //是否开放
    @IBOutlet var IdLabel:UILabel!
}