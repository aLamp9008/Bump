//
//  InfectedController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit
import Alamofire
class BumpInfectedController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var tabelView: UITableView!
    var somethingDict = [String : Bool]()
    var STDList = [String]()
    var newArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor();
        self.navigationController!.navigationBar.topItem!.title = "Bump"
        
        self.navigationItem.title = "Infected"
        
        
        for (value, _) in STDDict{
            STDList.append(value)
            somethingDict[value] = false
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return STDList.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        cell.textLabel?.text = STDList[indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var std = STDList[indexPath.row]
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyy"
        let stringDate = dateFormatter.stringFromDate(NSDate())

        
        let request = NSMutableURLRequest(URL: NSURL(string:"http://phpdatabase19-bump-php-db.0ec9.hackathon.openshiftapps.com/dashboard2.php")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = "username=\(currentUser)&password=\(currentPassword)&disease=\(std)&disease_date=\(stringDate)".dataUsingEncoding(NSUTF8StringEncoding)
        
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
        
        var partners: NSArray{
            get{
                var array = [String]()
                
                    if let user : NSDictionary = values[currentUser] as? NSDictionary{
                        for (keys, _) in user["Partners"] as! NSDictionary{
                            array.append(keys as! String)
                            
                        }
                        
                    
                }
                return array
            }
        }
        
        
        print(partners)
        
        var phoneNums = [String]()
        
        for a in partners{
            if let something : String = values[String(a)]?["PhoneNum"] as? String{
                phoneNums.append(something)
            }
        }
        print(phoneNums)
        for a in phoneNums{
            
            
            let index = a.startIndex.advancedBy(0)
            var toNumber = ""
            if a[index] == "1"{
                toNumber = "%2B\(a)"
            }else{
                toNumber = "%2B1\(a)"
            }
            
            
            let twilioSID = "ACa53472c53e3e8a477617ac2bcaf6a07e"
            let twilioSecret = "825fd297a8fe82a54997fdfa3aed05d1"
            
            //Note replace + = %2B , for To and From phone number
            let fromNumber = "%2B16466797557"// actual number is +14803606445
            let message = "You may have \(std). Get a checkup. Please refrain from sexual contact. Please refer to the STD info of our app for more info.\n\n~Bump Team"
            
            // Build the request
            let request = NSMutableURLRequest(URL: NSURL(string:"https://\(twilioSID):\(twilioSecret)@api.twilio.com/2010-04-01/Accounts/\(twilioSID)/SMS/Messages")!)
            request.HTTPMethod = "POST"
            request.HTTPBody = "From=\(fromNumber)&To=\(toNumber)&Body=\(message)".dataUsingEncoding(NSUTF8StringEncoding)
            
            // Build the completion block and send the request
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
        }
        
        performSegueWithIdentifier("showHome", sender: nil)
        
        
    }
    
    
    
}
