//
//  QRcodeShowViewController.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-28.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit

class QRcodeShowViewController: UIViewController {

    var ActivityID:String?
    var IndexName:String?
    
    @IBOutlet var QRcodeView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        var url : NSURL = NSURL(string: "http://172.16.100.41:8080/PersonCenter/Public/CreatCode/" + ActivityID!)!
        var data : NSData = NSData(contentsOfURL:url)!
        QRcodeView.image = UIImage(data:data, scale: 1.0)
        QRcodeView.contentMode = UIViewContentMode.ScaleAspectFit
        title = IndexName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
