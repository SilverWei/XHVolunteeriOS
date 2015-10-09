//
//  SettingEditTableViewController.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-14.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit

class SettingEditTableViewController: UITableViewController {

    var UserEditOut:EditOut?
    
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
        let UserDetail:InfoOut! = GetUserInfo()
        if(UserDetail != nil)
        {
            let cell = tableView.self as! EditUserCell
            cell.UserNameUILabel.text = UserDetail.UserName
            cell.PhoneNumberTextField.text = UserDetail.PhoneNumber
            cell.QQNumberTextField.text = UserDetail.QQNumber
            cell.PersonalInfoTextField.text = UserDetail.PersonalInfo
            cell.SexSegmentedControl.selectedSegmentIndex = UserDetail.Sex == true ? 0 : 1
        }
        else
        {
            let alert = UIAlertView()
            alert.title = "错误"
            alert.message = "网络连接失败！"
            alert.addButtonWithTitle("确定")
            alert.show()
        }
    }
    
    @IBAction func CloseViewButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
