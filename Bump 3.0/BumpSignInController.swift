//
//  SignInController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit
import Alamofire

let urlString = "http://phpdatabase6-bump-php-db.0ec9.hackathon.openshiftapps.com/phptojson.php"
var currentUser = ""
var currentPhone = ""
var currentGender = false

var values: AnyObject = ""

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
        
        
        let request = NSMutableURLRequest(URL: NSURL(string:"http://phpdatabase16-bump-php-db.0ec9.hackathon.openshiftapps.com/dashboard.php")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = "username=\"test2\"&password=\"test\"&phone_num=\"9735555555\"&gender=\"Male\"".dataUsingEncoding(NSUTF8StringEncoding)
        
        viewReady()
        getJson()
    }
    
    func getJson(){
    var somethingString = ""
        
        
        
        Alamofire.request(.GET, "http://phpdatabase16-bump-php-db.0ec9.hackathon.openshiftapps.com/results.json")
            .validate(contentType: ["test/html"])
            .response { (response) in
                
                somethingString = String(response.2)
                
                somethingString = somethingString.stringByReplacingOccurrencesOfString("Optional(<", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                somethingString = somethingString.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                somethingString = somethingString.stringByReplacingOccurrencesOfString(">)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
                let data = self.dataWithHexString(somethingString) // <68656c6c 6f2c2077 6f726c64>
                

                
                
                if let string = String(data: data, encoding: NSUTF8StringEncoding){
                    
                        
                    
                    
                    
                    var str = string.stringByReplacingOccurrencesOfString("}{", withString: ",", options: NSStringCompareOptions.LiteralSearch, range: nil)
                    str = str.stringByReplacingOccurrencesOfString("\\\\\\", withString: "\\", options: NSStringCompareOptions.LiteralSearch, range: nil)
                    
                    print(str)
                    if let dictionary = self.parseJSON("{\"charlieg1234\": {\"password\" : \"1234abc\",\"PhoneNum\" :\"543-567-1234\",\"Gender\":true, \"Diseases\":{\"HIV\":\"09/01/2016\", \"AIDS\":\"09/13/2016\"},\"Partners\":{\"Sara Jones\":\"09/15/2016\"}},\"test\": {\"password\" : \"test\",\"PhoneNum\" :\"9735555555\",\"Gender\":true, \"Diseases\":{},\"Partners\":{}}}") {
                        print("dictionary: \(dictionary)")
                    }
                    
//                    let somethingSmoething : [String: AnyObject] = self.convertStringToDictionary(str)!
//                    print(somethingSmoething)
                }
                
                
        }
        
        
        
    
    }
    


    
    func parseJSON(jsonString: String) -> [String: AnyObject]? {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            
            do{
            
            return try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? [String: AnyObject]
            
            }catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
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
            
            if let personalUser = values[username.text!]?!{
                if personalUser["password"] as? String == password.text{
                    able = true
                }
                
                if (able){
                    performSegueWithIdentifier("loggedIn", sender: nil)
                    currentUser = username.text!
                    currentPhone =  values[username.text!]!!["PhoneNum"]!! as! String
                    currentGender = values[username.text!]!!["Gender"]!! as! Bool
                    
                } else{
                    
                    fillOutFollowing.text = "The password is invalid"
                    fillOutFollowing.hidden = false
                }
            } else{
                
                fillOutFollowing.text = "The Username is invalid"
                fillOutFollowing.hidden = false
                
            }
        }//make and give and error message on view
        else{
            
            fillOutFollowing.text = "Please fillout all of the following"
            fillOutFollowing.hidden = false
            
        }
        
    }
    
}

