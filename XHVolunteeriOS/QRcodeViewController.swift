//
//  QRcodeViewController.swift
//  XHVolunteeriOS
//
//  Created by silverwei on 15-4-14.
//  Copyright (c) 2015年 NineSoft. All rights reserved.
//

import UIKit
import AVFoundation

class QRcodeViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var messageLabel: UILabel!
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var ActivityID:String = ""
    @IBOutlet weak var QRView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error:NSError?
        let input:AnyObject!
        do {
            input = try AVCaptureDeviceInput(device: captureDevice)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if(error != nil)
        {
            print("\(error?.localizedDescription)")
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession?.addInput(input as! AVCaptureInput)
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = QRView.layer.bounds
        QRView.layer.addSublayer(videoPreviewLayer!)
        
        captureSession?.startRunning()
        
        QRView.bringSubviewToFront(messageLabel)
        
        
//        qrCodeFrameView = UIView()
//        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
//        qrCodeFrameView?.layer.borderWidth = 2
//        QRView.addSubview(qrCodeFrameView!)
//        QRView.bringSubviewToFront(qrCodeFrameView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0
        {
            qrCodeFrameView?.frame = CGRectZero
            messageLabel.text = "请在活动结束后再次进行签到以累计时长！"
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode
        {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds
            
            ActivityID = metadataObj.stringValue
            
            if metadataObj.stringValue != nil
            {
                captureSession?.stopRunning()
                
                //数据传输
                let ScanRequest = ScanCode(metadataObj.stringValue)
                if(ScanRequest.request == ScanType.First) //第一次扫描
                {
                    let alert = UIAlertView()
                    alert.title = "提示"
                    alert.message = "活动签到成功！"
                    alert.addButtonWithTitle("确定")
                    alert.show()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else if(ScanRequest.request == ScanType.Second) //第二次扫描
                {
                    print(ScanRequest.ActivityName)
                    
                    let alert = UIAlertView()
                    alert.title = "是否完结当前参与的活动"
                    alert.message = "当前参与的活动为\"" + ScanRequest.ActivityName! + "\"，累计时长为\(ScanRequest.ActivityLong)分钟。"
                    alert.addButtonWithTitle("确定")
                    alert.addButtonWithTitle("取消")
                    alert.cancelButtonIndex = 1
                    alert.delegate = self
                    alert.show()
                //    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else if(ScanRequest.request == ScanType.Error)
                {
                    let alert = UIAlertView()
                    alert.title = "错误"
                    alert.message = ScanRequest.Errormsg
                    alert.addButtonWithTitle("确定")
                    alert.show()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }

            }
        }

    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex:Int)
    {
        if(buttonIndex == alertView.cancelButtonIndex)
        {
            print("点击了取消")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            
            print("点击了确认")
            
            let TwoScanRequest = TwoScanCode(ActivityID)
            if(TwoScanRequest.request == ScanType.Error)
            {
                let alert = UIAlertView()
                alert.title = "提示"
                alert.message = TwoScanRequest.Errormsg
                alert.addButtonWithTitle("确定")
                alert.show()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else
            {
                let alert = UIAlertView()
                alert.title = "提示"
                alert.message = "您已完结本活动！"
                alert.addButtonWithTitle("确定")
                alert.show()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }

    @IBAction func CloseViewButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
