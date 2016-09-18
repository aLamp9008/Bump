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
    
    var cell = TableViewCell()
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell
        
        cell.label.text = STDList[indexPath.row]
        cell.checkImage.hidden = true
        cell.checkImage.image = UIImage(named: "checkmark_filled")
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        somethingDict[STDList[indexPath.row]] = true
        newArray.append(STDList[indexPath.row])
        cell.checkImage.hidden = false
        
    }
    
    @IBAction func send(sender: AnyObject) {
        
        var partners: NSArray{
            get{
                var user = NSDictionary()
                var array = [String]()
                Alamofire.request(.GET, urlString).responseJSON { (responce) in
                    if let JSON = responce.result.value{
                        values = JSON
                        print("success")
                        user = values["users"]!![currentUser]! as! NSDictionary
                    }
                }
                var something : NSDictionary = user["partners"]! as! NSDictionary
                for (keys, _) in something{
                 array.append(keys as! String)
                }
                return array
            }
        }
        var phoneNums = [String]()
        for a in partners{
            var user : NSDictionary = values["users"]!![a as! String]! as! NSDictionary
            
            phoneNums.append(String(user["phoneNumber"]))
        }
        
        
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
            let message = "HEHEHEHEHEHEHEHEHEHEHE"
            
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
    }
    
    
    
}
