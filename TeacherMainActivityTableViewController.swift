//
//  TeacherMainActivityTableViewController.swift
//  XHVolunteeriOS
//
//  Created by pcbeta on 15-5-4.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit

class TeacherMainActivityTableViewController: UITableViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var loadMoreText = UILabel()
    let tableFooterView = UIView()
    var page = 1
    var itemNumber:RequestType = RequestType.Manager
    var Skip = 0
    var AllActivityDB:[ActivityDB] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //下拉刷新
        var  refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("sortArray"), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新活动")
        self.refreshControl = refreshControl
        
        //上拉加载
        self.createTableFooter()
        
        ActivityLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //下拉刷新
    func sortArray(){
        AllActivityDB = []
        Skip = 0
        ActivityLoad()
        println("下来刷新")
        tableView.reloadData()
        
        refreshControl?.endRefreshing()
        
        if self.refreshControl?.refreshing == false{
            self.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新活动")
        }
    }
    
    //上拉加载
    func createTableFooter(){
        self.tableView.tableFooterView = nil
        tableFooterView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 60)
        loadMoreText.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 60)
        loadMoreText.text = "上拉查看更多"
        loadMoreText.textAlignment = NSTextAlignment.Center
        tableFooterView.addSubview(loadMoreText)
        self.tableView.tableFooterView = tableFooterView
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 30){
            loadMoreText.text = "上拉查看更多"
        }
        else{
            loadMoreText.text = "已无更多数据"
        }
        if(AllActivityDB.count == 0){
            loadMoreText.text = "没有相关数据"
        }
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        loadMoreText.text = "加载数据中"
        
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 30){
            page++
            self.initArr()
            print("更新数据")
            self.tableView.reloadData()
            
        }
    }
    
    func initArr(){
        ActivityLoad()
        self.tableView.reloadData()
    }
    
    func ActivityLoad(){
        var ActivityAll:PtrResponse = GetActivitiesData(PullDownRequest(ptrRequest: PtrRequest(Skip: Skip, Count: 10, LocalData: PtrUpdateParam(Id: nil, IndexId: nil, Tick: nil), Guid: ""), request: itemNumber))
        
        for i in 0..<ActivityAll.updatedata.count{
            
            var Activity = ActivityAll.updatedata[i] as PtrUpdaeData!
            
            AllActivityDB.append(ActivityDB(IndexId:Activity.Data.IndexId , ActivityName: Activity.Data.ActivityName, TeamName: Activity.Data.TeamName, UserName: Activity.Data.UserName, ActivityStartTime: Activity.Data.ActivityStartTime, ActivityEndTime: Activity.Data.ActivityEndTime, ActivityLocation: Activity.Data.ActivityLocation, ActivitySummary: Activity.Data.ActivitySummary, ActivityState: Activity.Data.ActivityState, ActivityAttend: Activity.Data.ActivityAttend, JoinCount: Activity.Data.JoinCount, Tick: Activity.Data.Tick, IsJoining: Activity.Data.IsJoining, Id: Activity.Data.Id))
        }
        Skip += 10
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllActivityDB.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ActivityOneCell = AllActivityDB[indexPath.row] as ActivityDB
        let cell = tableView.dequeueReusableCellWithIdentifier("AllActivityCell", forIndexPath: indexPath) as! ActivityCell
        
        cell.ActivityNameLabel.text = ActivityOneCell.ActivityName
        cell.ActivityStartTimeLabel.text = "开始时间：" + DateTimeChange(ActivityOneCell.ActivityStartTime)
        cell.ActivityEndTimeLabel.text = "结束时间：" + DateTimeChange(ActivityOneCell.ActivityEndTime)
        return cell
        
    }
    
    func DateTimeChange(DateTime:String) -> String{
        return (DateTime as NSString).substringToIndex(10) + " " + ((DateTime as NSString).substringFromIndex(11) as NSString).substringToIndex(5)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowActivityDetail")
        {
            if let index = self.tableView.indexPathForSelectedRow()
            {
                let ActivityOneCell = AllActivityDB[index.row] as ActivityDB
                
                (segue.destinationViewController as! ActivityDetailTableViewController).indexId = ActivityOneCell.IndexId
                
            }
            
        }
    }
    
}
