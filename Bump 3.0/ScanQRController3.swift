//
//  ScanQRController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
class BumpScanQRController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    
    @IBOutlet var webView: UIWebView!
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet var scannerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print()
        
        
        
        
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        scannerView.layer.addSublayer(previewLayer);
        
        captureSession.startRunning();
        
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        captureSession = nil
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.running == false) {
            captureSession.startRunning();
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.running == true) {
            captureSession.stopRunning();
        }
    }
    
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            
            
            foundCode(readableObject.stringValue);
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func foundCode(code: String) {

            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

        var found = false
        for (keys, value) in values as! NSDictionary {
            
            if code == keys as! String{
                found = true
            }
            
        }
        
        if found == true{
            

            
            let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyy"
                let stringDate = dateFormatter.stringFromDate(NSDate())
                
                let request = NSMutableURLRequest(URL: NSURL(string:"http://phpdatabase19-bump-php-db.0ec9.hackathon.openshiftapps.com/dashboard3.php")!)
                request.HTTPMethod = "POST"
                request.HTTPBody = "username=\(currentUser)&password=\(currentPassword)&partener=\(code)&partner_date=\(stringDate)".dataUsingEncoding(NSUTF8StringEncoding)
                
                NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                    print("Finished")
                    if let data = data, responseDetails = NSString(data: data, encoding: NSUTF8StringEncoding) {
                        // Success
                        print("Response: \(responseDetails)")
                    } else {
                        // Failure
                        print("Error: \(error)")
                    }
                }).resume()
            
            webView.loadRequest(NSURLRequest(URL: NSURL(string : "http://phpdatabase19-bump-php-db.0ec9.hackathon.openshiftapps.com/phptojson.php")!))
            
            performSegueWithIdentifier("backHome", sender: nil)
            }
        

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }


}
