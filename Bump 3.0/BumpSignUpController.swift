//
//  ViewController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit
import Alamofire

class BumpSignUpController: UIViewController {
    
    @IBOutlet var phoneNumberSignUp: UITextField!
    @IBOutlet var passwordSignUp: UITextField!
    @IBOutlet var userNameSignUp: UITextField!
    
    @IBOutlet var phoneNumberView: UIView!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var usernameView: UIView!
    
    @IBOutlet var genderView: UIView!
    @IBOutlet var femaleButton: UIButton!
    @IBOutlet var maleButton: UIButton!
    
    @IBOutlet var fillOutFollowingLabel: UILabel!
    @IBOutlet var background: UIImageView!
    
    var genderChosen = false
    var isMale = false
    
    
    var Aarray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        fillOutFollowingLabel.hidden = true
        
        
        
        viewReady()
        Alamofire.request(.GET, urlString).responseJSON { (responce) in
            if let JSON = responce.result.value{
                print(JSON)
            }
        }
    }
    
    
    
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    func viewReady(){
        
        let clearColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).CGColor
        
        background.layer.zPosition = -1
        
        userNameSignUp.backgroundColor = clearColor
        usernameView.backgroundColor = clearColor
        passwordSignUp.backgroundColor = clearColor
        passwordView.backgroundColor = clearColor
        phoneNumberSignUp.backgroundColor = clearColor
        phoneNumberView.backgroundColor = clearColor
        genderView.backgroundColor = clearColor
        
        usernameView.layer.borderWidth = 1.5
        usernameView.layer.borderColor = white
        passwordView.layer.borderWidth = 1.5
        passwordView.layer.borderColor = white
        phoneNumberView.layer.borderWidth = 1.5
        phoneNumberView.layer.borderColor = white
        maleButton.layer.borderWidth = 1.5
        maleButton.layer.borderColor = white
        femaleButton.layer.borderWidth = 1.5
        femaleButton.layer.borderColor = white
        
        userNameSignUp.attributedPlaceholder = NSAttributedString(string:"Username", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        passwordSignUp.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        phoneNumberSignUp.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes:[NSForegroundColorAttributeName : UIColor.whiteColor()])
        
    }
    
    
    
    
    @IBAction func genderFemale(sender: AnyObject) {
        
        genderChosen = true
        isMale = false
        
        maleButton.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        femaleButton.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.47)
        
    }
    
    @IBAction func genderMale(sender: AnyObject) {
        
        genderChosen = true
        isMale = true
        
        maleButton.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.47)
        femaleButton.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
    }

    
    //amke a sign in button function
    //get JSON from database to test if uniqu username
    //performSegue/ set currnen PersonalInfo
    

    @IBAction func signUp(sender: AnyObject) {
        
        if genderChosen == true && userNameSignUp.text != nil && phoneNumberSignUp.text != nil && passwordSignUp.text != nil{
            
            
            
            
            
            var something = true
           
            for (key, value) in values as! NSDictionary{
                
                if userNameSignUp.text == String(key){
                    something = false
                }
                
            }
            
            
            
            
            
            if (something){
                
                var parameters =
                    [
                    userNameSignUp.text!:[
                        "password" : passwordSignUp.text!,
                        "PhoneNum" : phoneNumberSignUp.text!,
                        "Gender" : isMale,
                        "Diseases" : ["nil" : "0/0/00"],
                        "Partners" : ["example" : "0/0/00"]
                    ]
                ]
                
                Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON)
                performSegueWithIdentifier("showHome", sender: nil)
            }else{
                fillOutFollowingLabel.text = "Username taken"
                fillOutFollowingLabel.hidden = false
            }
            
            
        }else{
            fillOutFollowingLabel.text = "Please fill out all of the folliowing"
            fillOutFollowingLabel.hidden = true
        }
        
    }
    
    
    
    
    

}

