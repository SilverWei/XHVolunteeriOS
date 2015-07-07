//
//  ActivityDetailTableViewController.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-14.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit

class ActivityDetailTableViewController: UITableViewController ,UIActionSheetDelegate {

    var ActivityDetail:ActivityInfos!
    var indexId:Int!
    @IBOutlet weak var MenuButton: MKButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ActivityDetail = GetActivityInfos(活动ID: indexId)
        

        
        ActivityDetailShow()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //读取活动详细信息
    func ActivityDetailShow()
    {
        let cell = tableView.self as! ActivityDetailCell
        cell.ActivityNameLabel.text = ActivityDetail.ActivityName
        cell.ActivityLocationLabel.text = ActivityDetail.ActivityLocation
        cell.UserNameLabel.text = ActivityDetail.UserName
        cell.JoinCountLabel.text = ActivityDetail.JoinCount.description + "/" + ActivityDetail.ActivityAttend.description
        cell.ActivityStartTimeLabel.text = DateTimeChange(ActivityDetail.ActivityStartTime)
        cell.ActivityEndTimeLabel.text = DateTimeChange(ActivityDetail.ActivityEndTime)
        cell.ActivitySummaryLabel.text = ActivityDetail.ActivitySummary
        cell.TeamNameLabel.text = ActivityDetail.TeamName
        println(ActivityDetail.JoinCount)
        tableView.reloadData()
        //学生隐藏菜单按钮
        if(Identity == UserIdentity.MemberView && ActivityDetail.IsJoining == true)
        {
            MenuButton.hidden = true
        }
    }
    
    //日期格式转化
    func DateTimeChange(DateTime: String) -> String
    {
        return (DateTime as NSString).substringToIndex(10) + " " + ((DateTime as NSString).substringFromIndex(11) as NSString).substringToIndex(5)
    }
    
    //右上角弹出菜单内容
    @IBAction func ActivityMenu(sender: UIButton) {
        var actionSheet = UIActionSheet()
        actionSheet.addButtonWithTitle("取消")
        if(Identity == UserIdentity.TeacherView)
        {
            actionSheet.addButtonWithTitle("生成二维码")
            actionSheet.addButtonWithTitle("结束活动")
        }
//        if(Identity == UserIdentity.MemberView && ActivityDetail.IsJoining == false)
//        {
//            actionSheet.addButtonWithTitle("加入活动")
//        }

        actionSheet.cancelButtonIndex = 0
        actionSheet.delegate = self
        actionSheet.showInView(self.tableView)
    }

    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        println(buttonIndex)
        
        switch buttonIndex
        {
        case (1):
            println("生成二维码")
            QRcodeGet()
        case (2):
            println("结束活动")
            println(EndActivity(活动ID: ActivityDetail.ActivityID).ErrorMsg)
            ActivityDetailShow()
        case (3):
            println("加入活动")
            
            var alert = UIAlertView()
            alert.title = "提示"
            alert.message = AddApply(ActivityDetail.ActivityID).ErrorMsg
            alert.addButtonWithTitle("确认")
            alert.show()
            
            ActivityDetailShow()
        default:
            println("取消")
        }
    }
    
    func QRcodeGet() //获取二维码
    {
        self.performSegueWithIdentifier("QRcodeShowView", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "QRcodeShowView" //进入数据详情页面 ShowActivity为storyboard的ldentifier标示
        {
            (segue.destinationViewController as! QRcodeShowViewController).ActivityID = ActivityDetail.ActivityID
            (segue.destinationViewController as! QRcodeShowViewController).IndexName = ActivityDetail.ActivityName
        }
    }


}
