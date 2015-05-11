//
//  LoginViewController.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-17.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit

var Identity:UserIdentity?

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var UserName: MKTextField!
    
    @IBOutlet var UserPassword: MKTextField!
    
    @IBOutlet var LoginButton: MKButton!
    
    let UserNameKey = ""
    let PwdKey = ""
    let IsFirstLaunch = "ifl"

    override func viewDidLoad() {
        super.viewDidLoad()

        LoginButton.layer.shadowOpacity = 0.55
        LoginButton.layer.shadowRadius = 5.0
        LoginButton.layer.shadowColor = UIColor.grayColor().CGColor
        
        UserName.layer.borderColor = UIColor.clearColor().CGColor
        UserName.floatingPlaceholderEnabled = true
        UserName.placeholder = "用户名："
        UserName.rippleLayerColor = UIColor.MKColor.LightBlue
        UserName.tintColor = UIColor.MKColor.Blue
        UserName.backgroundColor = UIColor(hex: 0xE0E0E0)
        
        UserPassword.layer.borderColor = UIColor.clearColor().CGColor
        UserPassword.floatingPlaceholderEnabled = true
        UserPassword.placeholder = "密码："
        UserPassword.rippleLayerColor = UIColor.MKColor.LightBlue
        UserPassword.tintColor = UIColor.MKColor.Blue
        UserPassword.backgroundColor = UIColor(hex: 0xE0E0E0)
    }
    
    override func viewDidAppear(animated: Bool) {
        LastLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //读取上次登录信息
    func LastLogin()
    {
        //读取上次配置
        self.UserName.text = NSUserDefaults.standardUserDefaults().valueForKey("UserNameKey") as String!
        self.UserPassword.text = NSUserDefaults.standardUserDefaults().valueForKey("PwdKey") as String!
        
        //判断是否第一次启动：
        if((NSUserDefaults.standardUserDefaults().boolForKey("IsFirstLaunch") as Bool!) == false){
            //第一次启动，播放引导页面
            println("第一次启动")
            self.performSegueWithIdentifier("GuideShow", sender: self)
            //设置为非第一次启动
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "IsFirstLaunch")
        }else{
            println("不是第一次启动")
            if((self.UserPassword.text) != "")
            {
                UserLoginButton(LoginButton)
            }

        }
    }

    @IBAction func UserLoginButton(sender: UIButton) {
        LoginOn()
        
        //设置存储信息
        NSUserDefaults.standardUserDefaults().setObject(self.UserName.text, forKey: "UserNameKey")
        NSUserDefaults.standardUserDefaults().setObject(self.UserPassword.text, forKey: "PwdKey")

        //设置同步
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func LoginOn()
    {
        let pullDownResult:PullDownResult = UserLogin(用户名: UserName.text,密码: UserPassword.text)
        
        if(pullDownResult.PtrRequest == ResultType.Success)
        {
            if(pullDownResult.ErrorMsg == "成员")
            {
                self.performSegueWithIdentifier("MemberView", sender: self)
                Identity = UserIdentity.MemberView
            }
            else if (pullDownResult.ErrorMsg == "负责人" || pullDownResult.ErrorMsg == "具体负责人")
            {
                self.performSegueWithIdentifier("TeacherView", sender: self)
                Identity = UserIdentity.TeacherView
            }
        }
        else
        {
            var alert = UIAlertView()
            alert.title = "错误"
            alert.message = pullDownResult.ErrorMsg
            alert.addButtonWithTitle("取消")
            alert.show()
        }
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //收起键盘
        UserName.resignFirstResponder()
        UserPassword.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}
