//
//  ForgotPasswordController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit
import Alamofire

class BumpForgotPasswordController: UIViewController {
    
    @IBOutlet var directionsLabel: UILabel!
    @IBOutlet var textFeild: UITextField!
    @IBOutlet var background: UIImageView!
    @IBOutlet var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        textFeild.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        textFeild.layer.borderWidth = 1.5
        textFeild.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).CGColor
        textFeild.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        background.layer.zPosition = -1
        nextButton.setTitle("Next", forState: .Normal)
        
    }
    
    func dismissKeyboard(){
        
        view.endEditing(true)
        
    }
    
    
    func generateRandomNumber(numDigits : Int) -> Double{
        var place = 0.1
        var finalNumber = 0.0
        for(var i = 0; i < numDigits; i++){
            place *= 10
            var randomNumber = arc4random_uniform(10)
            finalNumber += Double(randomNumber) * place
        }
        return finalNumber
    }
    
    @IBAction func next(sender: UIButton) {
        
        var twilPhone = ""
        
        if sender.currentTitle == "Next"{
            
            if let personalUser = values[textFeild.text!]{
                
                let randomNum =  generateRandomNumber(4)
                NSUserDefaults.standardUserDefaults().setValue(randomNum, forKey: "randomNum")
                NSUserDefaults.standardUserDefaults().setValue(personalUser, forKey: "personalUser")
                NSUserDefaults.standardUserDefaults().setValue(textFeild.text, forKey: "username")
                twilPhone = String(personalUser["phoneNum"])
                directionsLabel.text = "please type in the varification code"
                
                var toNumber = ""
                
                if twilPhone[twilPhone.startIndex.advancedBy(0)] == "1"{
                    
                    toNumber = "%2B\(twilPhone)"
                    
                }else {
                    toNumber = "%2B1\(twilPhone)"
                }
                
                
                
                //Note replace + = %2B , for To and From phone number
                
                let message = "Here's your Bump varification code: \(randomNum)"
                
                // Build the request
                
                let request = NSMutableURLRequest(URL: NSURL(string:"https://ACa53472c53e3e8a477617ac2bcaf6a07e:825fd297a8fe82a54997fdfa3aed05d1@api.twilio.com/2010-04-01/Accounts/ACa53472c53e3e8a477617ac2bcaf6a07e/SMS/Messages")!)
                request.HTTPMethod = "POST"
                request.HTTPBody = "From=%2B16466797557&To=\(toNumber)&Body=\(message)".dataUsingEncoding(NSUTF8StringEncoding)
                
                
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
                
                nextButton.setTitle("Validate", forState: .Normal) as! String
                
            }else{
                directionsLabel.text = "invalid username"
            }
        }else if sender.currentTitle == "Validate"{
         
            var code = NSUserDefaults.standardUserDefaults().valueForKey("randomNum")
            if textFeild.text != nil{
                if textFeild.text! == String(code){
                   
                    nextButton.setTitle("Set Password", forState: .Normal)
                    
                    
                }else{
                    
                    directionsLabel.text = "inncorrect code"
                
                }
            }
            
        }else if sender.currentTitle == "Set Password"{
            
            
            
            if textFeild.text != nil{
                var userNewParameter: [String : AnyObject] = NSUserDefaults.standardUserDefaults().valueForKey("personalUser")! as! [String : AnyObject]
               
                userNewParameter["password"] = textFeild.text!
                
                var paramers = [NSUserDefaults.standardUserDefaults().valueForKey("username") as! String: userNewParameter]
                
                let request = NSMutableURLRequest(URL: NSURL(string:"http://phpdatabase19-bump-php-db.0ec9.hackathon.openshiftapps.com/dashboard.php")!)
                request.HTTPMethod = "POST"
                request.HTTPBody = "username=\(String(NSUserDefaults.standardUserDefaults().valueForKey("username")!))/&password=\(paramers["password"])&phone_num=\(paramers["phoneNum"])&gender=\(paramers["gender"])".dataUsingEncoding(NSUTF8StringEncoding)
                
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
                
                
                performSegueWithIdentifier("showHome", sender: nil)
            }else{
                directionsLabel.text = "invalid password"
            }
            
        }
        
    }

    
}
