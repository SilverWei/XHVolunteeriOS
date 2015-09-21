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
        var TeaPerImforDetail:InfoOut! = GetUserInfo()
        let cell = tableView.self as! EditTeaPerImfor
        cell.UserNameUILabel.text = TeaPerImforDetail.UserName
        cell.PhoneNumberTextField.text = TeaPerImforDetail.PhoneNumber
        cell.QQNumberTextField.text = TeaPerImforDetail.QQNumber

        cell.SexSegmentedControl.selectedSegmentIndex = TeaPerImforDetail.Sex == true  ? 0 :1
        
    }
    
    @IBAction func CloseViewButton(sender:AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
