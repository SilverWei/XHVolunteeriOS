//
//  IUserReposity.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-15.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation

protocol IUserReposity
{
    func GetUserInfo() -> InfoOut //获取用户信息
    func EditUser(性别 Sex:Bool, 联系方式 PhoneNumber:String, QQ号 QQNumber:String, 个人简介 PersonalInfo:String) //编辑用户信息
    func UserLogin(用户名 UserName:String, 密码 Password:String) -> PullDownResult //登录
}