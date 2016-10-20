//
//  SignInController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit

import Alamofire

var currentUser = ""
var currentPhone = ""
var currentGender = false
var currentPassword = ""

var values : [String : AnyObject] = [String : AnyObject]()

func convertStringToDictionary(text: String) -> [String:AnyObject]? {
    if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
        } catch let error as NSError {
            print(error)
        }
        
    }
    return nil
}

func dataWithHexString(hex: String) -> NSData {
    var hex = hex
    let data = NSMutableData()
    while(hex.characters.count > 0) {
        let c: String = hex.substringToIndex(hex.startIndex.advancedBy(2))
        hex = hex.substringFromIndex(hex.startIndex.advancedBy(2))
        var ch: UInt32 = 0
        NSScanner(string: c).scanHexInt(&ch)
        data.appendBytes(&ch, length: 1)
    }
    return data
}

class BumpSignInController: UIViewController {

    
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var fillOutFollowing: UILabel!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var usernameView: UIView!
    
    @IBOutlet var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            fillOutFollowing.hidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BumpSignInController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.navigationController?.navigationBarHidden = true
        
        
        
//        let request = NSMutableURLRequest(URL: NSURL(string:"http://phpdatabase19-bump-php-db.0ec9.hackathon.openshiftapps.com/dashboard.php")!)
//        request.HTTPMethod = "POST"
//        request.HTTPBody = "username=test&password=test&phone_num=9738738224&gender=true".dataUsingEncoding(NSUTF8StringEncoding)
//        
//        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
//            print("Finished")
//            if let data = data, responseDetails = NSString(data: data, encoding: NSUTF8StringEncoding) {
//                // Success
//                print("Response: \(responseDetails)")
//            } else {
//                // Failure
//                print("Error: \(error)")
//            }
//        }).resume()

        
        viewReady()
        getJson()
    }
    
    func getJson(){
    var somethingString = ""
        
        
        Alamofire.request(.GET, "http://phpdatabase19-bump-php-db.0ec9.hackathon.openshiftapps.com/results.json").responseJSON { (responce) in
            print(responce)
            let json = responce.result.value!
            
            
            
            
            var something = String(json)
             
            something = something.stringByReplacingOccurrencesOfString("}{", withString: ",", options: NSStringCompareOptions.LiteralSearch, range: nil)
            something = something.stringByReplacingOccurrencesOfString("Male", withString: "\"Male\"", options: NSStringCompareOptions.LiteralSearch, range: nil)
            something = something.stringByReplacingOccurrencesOfString("Felmale", withString: "\"Female\"", options: NSStringCompareOptions.LiteralSearch, range: nil)
            something = something.stringByReplacingOccurrencesOfString("\"\"", withString: "\",\"", options: NSStringCompareOptions.LiteralSearch, range: nil)
            something = something.stringByReplacingOccurrencesOfString("\\\"\\\"", withString: "\\\",\\\"", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            let json2 = convertStringToDictionary(something)!
            values = json2
            print(values)
            
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func viewReady(){
        
        let clearColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        background.layer.zPosition = -1
        
        username.backgroundColor = clearColor
        usernameView.backgroundColor = clearColor
        password.backgroundColor = clearColor
        passwordView.backgroundColor = clearColor
        
        passwordView.layer.borderColor = white.CGColor
        passwordView.layer.borderWidth = 1.5
        usernameView.layer.borderColor = white.CGColor
        usernameView.layer.borderWidth = 1.5
        
        username.attributedPlaceholder = NSAttributedString(string:"Username", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        password.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
    }
    
    
    @IBAction func signIn(sender: AnyObject) {
        
        var able = false
        if username.text != nil && password.text != nil{
            
            if let personalUser = values[username.text!]{
                if personalUser["password"] as? String == password.text{
                    able = true
                }
                
                if (able){
                    performSegueWithIdentifier("loggedIn", sender: nil)
                    currentUser = username.text!
                    currentPhone =  values[username.text!]!["PhoneNum"]!! as! String
                    if values[username.text!]!["Gender"]! as! CFBoolean == "Male" || values[username.text!]!["Gender"]!! as! CFBoolean == 1{
                        currentGender =  true
                    }else{
                        currentGender = false
                    }
                    currentPassword = values[username.text!]!["password"] as! String
                    print(currentUser)
                    print(currentPhone)
                    print(currentGender)
                    
                } else{
                    
                    fillOutFollowing.text = "The password is invalid"
                    fillOutFollowing.hidden = false
                }
            }else{
                
                fillOutFollowing.text = "The Username is invalid"
                fillOutFollowing.hidden = false
                
            
        }//make and give and error message on view
        }else{
            
            fillOutFollowing.text = "Please fillout all of the following"
            fillOutFollowing.hidden = false
            
        }
        
    }
    
}

