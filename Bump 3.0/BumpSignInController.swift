//
//  SignInController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit
import Alamofire

let urlString = "http://localhost/bump/test.php"
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
        
        viewReady()
        getJson()
    }
    
    func getJson(){
        
        Alamofire.request(.GET, urlString).responseJSON { (responce) in
            print("something")
            if let JSON = responce.result.value{
                values = JSON
                print("success")
                print(JSON)
            }
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
            
            if let personalUser = values["users"]?![username.text!]?!{
                if personalUser["password"] as? String == password.text{
                    able = true
                }
                
                if (able){
                    performSegueWithIdentifier("loggedIn", sender: nil)
                    currentUser = username.text!
                    currentPhone =  values["users"]!![username.text!]!!["phoneNumber"]!! as! String
                    currentGender = values["users"]!![username.text!]!!["Gender"]!! as! Bool
                    
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
