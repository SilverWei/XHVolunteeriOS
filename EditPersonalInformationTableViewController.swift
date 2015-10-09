//
//  EditPersonalInformationTableViewController.swift
//  XHVolunteeriOS
//
//  Created by pcbeta on 15-5-6.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit

class EditPersonalInformationTableViewController: UITableViewController {
    
    var UserEditOut:EditOut?

    override func viewDidLoad() {
        super.viewDidLoad()
        TeaPerImformationShow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func TeaPerImformationShow()
    {
        let TeaPerImforDetail:InfoOut! = GetUserInfo()
        if(TeaPerImforDetail != nil)
        {
            let cell = tableView.self as! EditTeaPerImfor
            cell.UserNameUILabel.text = TeaPerImforDetail.UserName
            cell.PhoneNumberTextField.text = TeaPerImforDetail.PhoneNumber
            cell.QQNumberTextField.text = TeaPerImforDetail.QQNumber
            cell.SexSegmentedControl.selectedSegmentIndex = TeaPerImforDetail.Sex == true  ? 0 :1
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
    
    @IBAction func CloseViewButton(sender:AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
