//
//  UserReposity.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-17.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation
var BaseUrlMUser = "172.16.100.41:8080/MUser"
var BaseUrl = "172.16.100.41:8080"

func UserLogin(用户名 UserName:String, 密码 Password:String) -> PullDownResult? //登录
{
    let urlStr = NSString(format: "http://%@/%@", BaseUrlMUser , "Login")
    let pullDownResult = PullDownResult(PtrRequest: ResultType.Error, ErrorMsg: "")
    
    
    if let url = NSURL(string: urlStr as String) {
        let postRequest = NSMutableURLRequest(URL: url)
        postRequest.timeoutInterval = 3.0
        postRequest.HTTPMethod = "POST"
        //postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let param = [
            "UserName":UserName,
            "Password":Password
        ]
        let jsonparam = try? NSJSONSerialization.dataWithJSONObject(param, options: NSJSONWritingOptions.PrettyPrinted)
        
        postRequest.HTTPBody = jsonparam
        if let response = try? NSURLConnection.sendSynchronousRequest(postRequest, returningResponse: nil) {
            let responsestr = NSString(data: response, encoding: NSUTF8StringEncoding)
            print(responsestr)
            
            let json = JSON(data: response)
            if let userResultType = json["Type"].int
            {
                pullDownResult.PtrRequest = ResultType(rawValue: userResultType)!
            }
            if let userRole = json["ErrorMsg"].string
            {
                pullDownResult.ErrorMsg = userRole
            }
            
        }
        else
        {
            return nil
        }
    }
    return pullDownResult
}

func GetUserInfo() -> InfoOut? //获取用户信息
{
    let urlStr = NSString(format: "http://%@/%@", BaseUrlMUser , "GetUserInfo")
    var UserInfo:InfoOut?
    
    if let url = NSURL(string: urlStr as String) {
        let postRequest = NSMutableURLRequest(URL: url)
        postRequest.timeoutInterval = 3.0
        postRequest.HTTPMethod = "POST"
        //postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let response = try? NSURLConnection.sendSynchronousRequest(postRequest, returningResponse: nil) {
            let responsestr = NSString(data: response, encoding: NSUTF8StringEncoding)
            print(responsestr)
            
            let json = JSON(data: response)
            UserInfo = InfoOut(UserID: json["UserID"].string!,
                UserName: json["UserName"].string!,
                UserRole: json["UserRole"].string!,
                PhoneNumber: json["PhoneNumber"].string!,
                TeamName: json["TeamName"].string!,
                QQNumber: json["QQNumber"].string!,
                PersonalInfo: json["PersonalInfo"] != nil ? json["PersonalInfo"].string! : "",
                ActivityLong: json["ActivityLong"].string!,
                Sex: json["Sex"].bool!,
                Tick: json["Tick"].int!,
                UserPicture: json["UserPicture"] != nil ? "http://" + BaseUrl + json["UserPicture"].string! : ""
            )
        }
    }
    else
    {
        return nil
    }
    
    return UserInfo
}

func EditUser(性别 Sex:Bool, 联系方式 PhoneNumber:String, QQ号 QQNumber:String, 个人简介 PersonalInfo:String) //编辑用户信息
{
    let urlStr = NSString(format: "http://%@/%@", BaseUrlMUser , "EditUserInfo")
    
    if let url = NSURL(string: urlStr as String) {
        let postRequest = NSMutableURLRequest(URL: url)
        postRequest.timeoutInterval = 3.0
        postRequest.HTTPMethod = "POST"
        //postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let param = [
            "Sex":Sex,
            "PhoneNumber":PhoneNumber,
            "QQNumber":QQNumber,
            "PersonalInfo":PersonalInfo
        ]
        let jsonparam = try? NSJSONSerialization.dataWithJSONObject(param, options: NSJSONWritingOptions.PrettyPrinted)
        
        postRequest.HTTPBody = jsonparam
        
        if let response = try? NSURLConnection.sendSynchronousRequest(postRequest, returningResponse: nil) {
            let responsestr = NSString(data: response, encoding: NSUTF8StringEncoding)
            print(responsestr)
        }
    }
}
