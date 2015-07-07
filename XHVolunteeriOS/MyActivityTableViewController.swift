//
//  MyActivityTableViewController.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-14.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit


class MyActivityTableViewController: UITableViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var loadMoreText = UILabel()//用于显示上拉刷新提示
    let tableFooterView = UIView()//列表的底部，用于显示“上拉查看更多”的提示，当上拉后显示类容为“松开加载更多”。
    var page = 1//上拉加载后的页数
    var itemNumber:RequestType = RequestType.Mine //页面组别初始化
    var Skip = 0//列表开始加载位置
    
    var AllActivityDB:[ActivityDB] = [] //初始化列表数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //下拉刷新
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("sortArray"), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新活动")
        self.refreshControl = refreshControl
        
        //上拉加载
        self.createTableFooter()
        
        ActivityLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    ////////////////////////////////////////////////////
    //上拉加载
    func createTableFooter(){//初始化tv的footerView
        self.tableView.tableFooterView = nil
        tableFooterView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 60)
        loadMoreText.frame =  CGRectMake(0, 0, self.tableView.bounds.size.width, 60)
        loadMoreText.text = "上拉查看更多"
        loadMoreText.textAlignment = NSTextAlignment.Center
        tableFooterView.addSubview(loadMoreText)
        self.tableView.tableFooterView = tableFooterView
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView){//开始上拉到特定位置后改变列表底部的提示
        
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 30){
            loadMoreText.text = "上拉查看更多"
        }
        else{
            loadMoreText.text = "上拉查看更多"
        }
        if(AllActivityDB.count == 0)
        {
            loadMoreText.text = "没有相关数据"
        }
    }
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool){
        loadMoreText.text = "载入数据中..."
        /*上拉到一定程度松开后开始加载更多*/
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 30){
            
            page++
            
            self.initArr()
            println("更新数据库")
            self.tableView.reloadData()
        }
    }
    func initArr(){//上拉后加载数组arr
        ActivityLoad()
        self.tableView.reloadData()
    }
    ////////////////////////////////////////////////////
    
    //下拉刷新
    func sortArray()
    {
        AllActivityDB = []//数据列表初始化
        Skip = 0
        ActivityLoad()
        
        println("下拉刷新")
        tableView.reloadData()
        
        refreshControl?.endRefreshing()
        if self.refreshControl?.refreshing == false
        {
            self.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新活动")
        }
    }
    
    //读取数据库附入数据列表
    func ActivityLoad()
    {
        var ActivityAll:PtrResponse = GetActivitiesData(PullDownRequest(ptrRequest: PtrRequest(Skip: Skip, Count: 10, LocalData: PtrUpdateParam(Id: nil, IndexId: nil, Tick: nil), Guid: ""), request: itemNumber))
        for i in 0..<ActivityAll.updatedata.count
        {
            var Activity = ActivityAll.updatedata[i] as PtrUpdaeData!
            
            AllActivityDB.append(ActivityDB(IndexId: Activity.Data.IndexId,
                ActivityName: Activity.Data.ActivityName,
                TeamName: Activity.Data.TeamName,
                UserName: Activity.Data.UserName,
                ActivityStartTime: Activity.Data.ActivityStartTime,
                ActivityEndTime: Activity.Data.ActivityEndTime,
                ActivityLocation: Activity.Data.ActivityLocation,
                ActivitySummary: Activity.Data.ActivitySummary,
                ActivityState: Activity.Data.ActivityState,
                ActivityAttend: Activity.Data.ActivityAttend,
                JoinCount: Activity.Data.JoinCount,
                Tick: Activity.Data.Tick,
                IsJoining: Activity.Data.IsJoining,
                Id: Activity.Data.Id))
        }
        Skip += 10
    }
    
    //点击顶部选择按钮显示不同的列表 "正在参与"／“已结束”／“缺席”
    @IBAction func segmentDidchange(sender: UISegmentedControl) {
        AllActivityDB = []//数据列表初始化
        Skip = 0
        
        switch sender.selectedSegmentIndex
        {
        case (0):
            itemNumber = RequestType.Mine
        case (1):
            itemNumber = RequestType.Finish
        case (2):
            itemNumber = RequestType.Leave
        default:
            println("segmentDidchange错误！")
        }
        ActivityLoad()
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllActivityDB.count
    }
    
    //每行表格显示数据内容
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ActivityOneCell = AllActivityDB[indexPath.row] as ActivityDB
        let cell = tableView.dequeueReusableCellWithIdentifier("MyActivityCell", forIndexPath: indexPath) as! ActivityCell
        
        cell.ActivityNameLabel.text = ActivityOneCell.ActivityName
        cell.ActivityStartTimeLabel.text = "开始时间：" + DateTimeChange(ActivityOneCell.ActivityStartTime)
        cell.ActivityEndTimeLabel.text = "结束时间：" + DateTimeChange(ActivityOneCell.ActivityEndTime)
        
        return cell
    }
    
    //日期格式转化
    func DateTimeChange(DateTime: String) -> String
    {
        return (DateTime as NSString).substringToIndex(10) + " " + ((DateTime as NSString).substringFromIndex(11) as NSString).substringToIndex(5)
    }

    
    //页面对外接口
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowActivity" //进入数据详情页面 ShowActivity为storyboard的ldentifier标示
        {
            println("显示详情")
            
            if let indexPath = self.tableView.indexPathForSelectedRow()
            {
                let ActivityOneCell = AllActivityDB[indexPath.row] as ActivityDB
                (segue.destinationViewController as! ActivityDetailTableViewController).indexId = ActivityOneCell.IndexId
            }
        }
    }
    
}
