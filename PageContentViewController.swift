//
//  PageContentViewController.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-5-5.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var PageImagesView: UIScrollView!

    //需要显示的页面内容
    var courses = [
        ["pic":"first1"],
        ["pic":"second"],
        ["pic":"third"]
    ]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //设置scrollView的内容总尺寸
        PageImagesView.contentSize = CGSizeMake(
            CGFloat(CGRectGetWidth(PageImagesView.bounds)) * CGFloat(self.courses.count),
            CGRectGetHeight(PageImagesView.bounds)
        )
        //关闭滚动条显示
        PageImagesView.showsHorizontalScrollIndicator = false
        PageImagesView.showsVerticalScrollIndicator = false
        PageImagesView.scrollsToTop = false
        //协议代理，在本类中处理滚动事件
        PageImagesView.delegate = self
        //滚动时只能停留到某一页
        PageImagesView.pagingEnabled = true
        //添加页面到滚动面板里
        let size = PageImagesView.bounds.size
        for (seq,course) in enumerate(courses) {
            var page = UIView()
            
            var images:UIImage = UIImage(named: course["pic"]!)!
            page.backgroundColor = UIColor(patternImage:UIImage(named:course["pic"]!)!)
            
            page.frame = CGRect(x: CGFloat(seq) * size.width, y: 0, width: PageImagesView.bounds.size.width, height: PageImagesView.bounds.size.height)
            PageImagesView.addSubview(page)
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
