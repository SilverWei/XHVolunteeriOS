//
//  ActivityReposity.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-17.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import Foundation
let BaseUrlMActivity = "172.16.100.41:8080/MActivity"

func GetActivitiesData(postData :PullDownRequest) -> PtrResponse?
{
    let urlStr = NSString(format: "http://%@/%@", BaseUrlMActivity , "GetActivitiesByPage") //GetActivitiesByPage是web端接口
    let param = PullDownRequest(ptrRequest: PtrRequest(Skip: postData.ptrRequest.Skip, Count: 10, LocalData: PtrUpdateParam(Id: nil, IndexId: nil, Tick: nil), Guid: ""), request: postData.request) //请求的数据模型
    var Response:PtrResponse? //返回值的定义
    
    if let url = NSURL(string: urlStr as String) {
        let postRequest = NSMutableURLRequest(URL: url)
        postRequest.timeoutInterval = 3.0
        postRequest.HTTPMethod = "POST"
        
        postRequest.HTTPBody = "{ptrRequest:{\"Skip\":\(param.ptrRequest.Skip),\"Count\":\(param.ptrRequest.Count),\"LocalData\":[],\"Guid\":\"\"},request:\"\(param.request.hashValue)\"}".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) //param数据转换为json格式发出请求
        
        if let response = try? NSURLConnection.sendSynchronousRequest(postRequest, returningResponse: nil) { //JSON返回数据
            
            //////////////////////////////////////////
            // 解析返回的JSON数据
            
            var json = JSON(data: response)
            var updateDB = [PtrUpdaeData]()
            for i in 0..<json["UpdateData"].count
            {
                updateDB.append(PtrUpdaeData(Type: UpdateType.NoChange, Data: ActivityDB(IndexId: json["UpdateData"][i]["Data"]["IndexId"].int!,
                    ActivityName: json["UpdateData"][i]["Data"]["ActivityName"].string!,
                    TeamName: json["UpdateData"][i]["Data"]["TeamName"].string!,
                    UserName: json["UpdateData"][i]["Data"]["UserName"].string!,
                    ActivityStartTime: json["UpdateData"][i]["Data"]["ActivityStartTime"].string!,
                    ActivityEndTime: json["UpdateData"][i]["Data"]["ActivityEndTime"].string!,
                    ActivityLocation: json["UpdateData"][i]["Data"]["ActivityLocation"].string!,
                    ActivitySummary: json["UpdateData"][i]["Data"]["ActivitySummary"].string!,
                    ActivityState: json["UpdateData"][i]["Data"]["ActivityState"].string!,
                    ActivityAttend: json["UpdateData"][i]["Data"]["ActivityAttend"].int!,
                    JoinCount: json["UpdateData"][i]["Data"]["JoinCount"].int!,
                    Tick: json["UpdateData"][i]["Data"]["Tick"].int!,
                    IsJoining: json["UpdateData"][i]["Data"]["IsJoining"].bool!,
                    Id: json["UpdateData"][i]["Data"]["Id"].int!)))
                
            }
            Response = PtrResponse(updatedata: updateDB, TotalCount: json["TotalCount"].int!, Guid: json["Guid"].string!)
        }
        else
        {
            return nil
        }
    }
    return Response!
}

func AddApply(ActivityID:String) -> PullDownResult //参加报名
{
    let urlStr = NSString(format: "http://%@/%@", BaseUrlMActivity , "JoinActivity")
    //    var UserRole:String = ""
    var Result:PullDownResult?
    
    if let url = NSURL(string: urlStr as String) {
        let postRequest = NSMutableURLRequest(URL: url)
        postRequest.timeoutInterval = 3.0
        postRequest.HTTPMethod = "POST"
        //postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let param = [
            "ActivityID":ActivityID
        ]
        let jsonparam = try? NSJSONSerialization.dataWithJSONObject(param, options: NSJSONWritingOptions.PrettyPrinted)
        
        postRequest.HTTPBody = jsonparam
        
        if let response = try? NSURLConnection.sendSynchronousRequest(postRequest, returningResponse: nil) {
            let responsestr = NSString(data: response, encoding: NSUTF8StringEncoding)
            print(responsestr)
            Result = PullDownResult(PtrRequest: nil, ErrorMsg: "您已加入此活动，请等待管理员审核！")
        }
    }
    return Result!
}
func ScanCode(ActivityID:String) -> ScanCodeResult? //首次刷二维码
{
    let urlStr = NSString(format: "http://%@/%@", BaseUrlMActivity , "ScanCode")
    var Result:ScanCodeResult?
    
    if let url = NSURL(string: urlStr as String) {
        let postRequest = NSMutableURLRequest(URL: url)
        postRequest.timeoutInterval = 3.0
        postRequest.HTTPMethod = "POST"
        //postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let param = [
            "ScanRequest":ActivityID
        ]
        let jsonparam = try? NSJSONSerialization.dataWithJSONObject(param, options: NSJSONWritingOptions.PrettyPrinted)
        
        postRequest.HTTPBody = jsonparam
        
        if let response = try? NSURLConnection.sendSynchronousRequest(postRequest, returningResponse: nil) {
            let responsestr = NSString(data: response, encoding: NSUTF8StringEncoding)
            print(responsestr)
            
            var json = JSON(data: response)
            Result = ScanCodeResult(request: ScanType(rawValue: json["request"].int!)!, Errormsg: json["Errormsg"].string, ActivityLong: json["ActivityLong"].int!, ActivityName: json["ActivityName"].string)
        }
        else
        {
            return nil
        }
    }
    return Result!
}
func TwoScanCode(ActivityID:String) -> ScanCodeResult? //第二次刷二维码
{
    let urlStr = NSString(format: "http://%@/%@", BaseUrlMActivity , "TwoScanCode")
    var Result:ScanCodeResult?
    
    if let url = NSURL(string: urlStr as String) {
        let postRequest = NSMutableURLRequest(URL: url)
        postRequest.timeoutInterval = 3.0
        postRequest.HTTPMethod = "POST"
        //postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let param = [
            "ScanRequest":ActivityID
        ]
        let jsonparam = try? NSJSONSerialization.dataWithJSONObject(param, options: NSJSONWritingOptions.PrettyPrinted)
        
        postRequest.HTTPBody = jsonparam
        
        if let response = try? NSURLConnection.sendSynchronousRequest(postRequest, returningResponse: nil) {
            
            var json = JSON(data: response)
            Result = ScanCodeResult(request: ScanType(rawValue: json["request"].int!)!, Errormsg: json["Errormsg"].string, ActivityLong: json["ActivityLong"].int!, ActivityName: json["ActivityName"].string)
        }
        else
        {
            return nil
        }
    }
    return Result!
}

func EndActivity(活动ID IndexId:Int) -> PullDownResult //结束活动
{
    let urlStr = NSString(format: "http://%@/%@", BaseUrlMActivity , "FinishActivity")
    var Result:PullDownResult?
    
    if let url = NSURL(string: urlStr as String) {
        let postRequest = NSMutableURLRequest(URL: url)
        postRequest.timeoutInterval = 3.0
        postRequest.HTTPMethod = "POST"
        //postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let param = [
            "IndexId":IndexId
        ]
        let jsonparam = try? NSJSONSerialization.dataWithJSONObject(param, options: NSJSONWritingOptions.PrettyPrinted)
        
        postRequest.HTTPBody = jsonparam
        
        if let response = try? NSURLConnection.sendSynchronousRequest(postRequest, returningResponse: nil) {
            let responsestr = NSString(data: response, encoding: NSUTF8StringEncoding)
            print(responsestr)
            Result = PullDownResult(PtrRequest: nil, ErrorMsg: "您已结束此活动！")
        }
    }
    return Result!
}

func GetActivityInfos(活动ID IndexId:Int) -> ActivityInfos?  //获取活动详细最新信息
{
    let urlStr = NSString(format: "http://%@/%@", BaseUrlMActivity , "GetActivity")
    var Response:ActivityInfos?
    
    if let url = NSURL(string: urlStr as String) {
        let postRequest = NSMutableURLRequest(URL: url)
        postRequest.timeoutInterval = 3.0
        postRequest.HTTPMethod = "POST"
        //postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let param = [
            "IndexId":IndexId,
            "tick":"635642848287116232"
        ]
        let jsonparam = try? NSJSONSerialization.dataWithJSONObject(param, options: NSJSONWritingOptions.PrettyPrinted)
        
        postRequest.HTTPBody = jsonparam
        
        if let response = try? NSURLConnection.sendSynchronousRequest(postRequest, returningResponse: nil) {
            let responsestr = NSString(data: response, encoding: NSUTF8StringEncoding)
            
            print(responsestr)
            //////////////////////////////////////////
            // 解析返回的JSON数据
            
            var json = JSON(data: response)
            Response = ActivityInfos(IndexId: json["IndexId"].int!,
                ActivityID: json["ActivityID"] != nil ? json["ActivityID"].string! : "",
                ActivityName: json["ActivityName"] != nil ? json["ActivityName"].string! : "",
                TeamName: json["TeamName"] != nil ? json["TeamName"].string! : "",
                UserName: json["UserName"] != nil ? json["UserName"].string! : "",
                ActivityStartTime: json["ActivityStartTime"] != nil ? json["ActivityStartTime"].string! : "",
                ActivityEndTime: json["ActivityEndTime"] != nil ? json["ActivityEndTime"].string! : "",
                ActivityLocation: json["ActivityLocation"] != nil ? json["ActivityLocation"].string! : "",
                ActivitySummary: json["ActivitySummary"] != nil ? json["ActivitySummary"].string! : "",
                ActivityState: json["ActivityState"] != nil ? json["ActivityState"].string! : "",
                ActivityAttend: json["ActivityAttend"].int!,
                JoinCount: json["JoinCount"].int!,
                Tick: json["Tick"].int!,
                IsJoining: json["IsApply"].bool!)
        }
        else
        {
            return nil
        }
    }
    return Response!
}