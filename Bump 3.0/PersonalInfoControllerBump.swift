//
//  PersonalInfoController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit

class BumpPersonalInfoController: UIViewController {

    @IBOutlet var userPhoneNumber: UILabel!
    @IBOutlet var userGender: UILabel!
    @IBOutlet var usernameHere: UILabel!
    @IBOutlet var selfImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor();
        self.navigationController!.navigationBar.topItem!.title = "Bump"
        
        self.navigationItem.title = "Personal Info"
        
        usernameHere.text = currentUser
        userGender.text = genderSomething(currentGender)
        userPhoneNumber.text = currentPhone
        switch currentGender {
        case true:
            selfImage.image = UIImage(named: "user-1")
        default:
            selfImage.image = UIImage(named: "user_female_body")
        }
        
    }

    func genderSomething (bool : Bool) -> String{ if (currentGender){ return "Male"; }else{ return "Female";}}

}
