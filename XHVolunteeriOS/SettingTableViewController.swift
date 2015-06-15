//
//  SettingTableViewController.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-14.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDetailShow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func UserDetailShow()
    {
        var UserDetail:InfoOut! = GetUserInfo()
        let cell = tableView.self as! GetUserCell
        cell.UserNameUILabel.text = UserDetail.UserName
        cell.PhoneNumberUILabel.text = UserDetail.PhoneNumber
        cell.TeamNameUILabel.text = UserDetail.TeamName
        cell.QQNumberUILabel.text = UserDetail.QQNumber
        cell.PersonalInfoUILabel.text = UserDetail.PersonalInfo
        cell.ActivityLongUILabel.text = UserDetail.ActivityLong + "小时"
        cell.SexUILabel.text = UserDetail.Sex == true ? "男" : "女"
    }
    
    @IBAction func saveUserEditDetail(segue:UIStoryboardSegue)
    {
        let EditUserController = segue.sourceViewController as! SettingEditTableViewController //调用SettingEditTableViewController页面
        let cell = EditUserController.tableView.self as! EditUserCell
        EditUser(性别: cell.SexSegmentedControl.selectedSegmentIndex == 0 ? true : false, 联系方式: cell.PhoneNumberTextField.text, QQ号: cell.QQNumberTextField.text, 个人简介: cell.PersonalInfoTextField.text)
        println("修改完成")
        UserDetailShow()
        tableView.reloadData()
    }
    
    //页面对外接口
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LoginOut" //进入数据详情页面 ShowActivity为storyboard的ldentifier标示
        {
            //设置存储信息
            NSUserDefaults.standardUserDefaults().setObject("", forKey: "UserNameKey")
            NSUserDefaults.standardUserDefaults().setObject("", forKey: "PwdKey")
            
            //设置同步
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}
