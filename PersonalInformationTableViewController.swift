//
//  PersonalInformationTableViewController.swift
//  XHVolunteeriOS
//
//  Created by pcbeta on 15-5-6.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit

class PersonalInformationTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TeaPerImformationShow()
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func TeaPerImformationShow()
    {
        var TeaPerImforDetail:InfoOut! = GetUserInfo()
        let cell = tableView.self as GetTeacherPerImfor
        cell.UserNameUILabel.text = TeaPerImforDetail.UserName
        cell.SexUILabel.text = TeaPerImforDetail.Sex == true ? "男" : "女"
        cell.QQNumberUILabel.text = TeaPerImforDetail.QQNumber

        cell.PhoneNumberUILabel.text = TeaPerImforDetail.PhoneNumber
        
    }
    
    @IBAction func savePerImfoEdit(segue:UIStoryboardSegue)
    {
        let EditPerImfoController = segue.sourceViewController as EditPersonalInformationTableViewController
        
        let cell = EditPerImfoController.tableView.self as EditTeaPerImfor
        EditUser(性别: cell.SexSegmentedControl.selectedSegmentIndex == 0 ? true : false, 联系方式: cell.PhoneNumberTextField.text, QQ号: cell.QQNumberTextField.text, 个人简介: "")
        
        TeaPerImformationShow()
        tableView.reloadData()
        
    }
    
    //页面对外接口
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PersonalLoginOut" //进入数据详情页面 ShowActivity为storyboard的ldentifier标示
        {
            //设置存储信息
            NSUserDefaults.standardUserDefaults().setObject("", forKey: "UserNameKey")
            NSUserDefaults.standardUserDefaults().setObject("", forKey: "PwdKey")
            
            //设置同步
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

}
