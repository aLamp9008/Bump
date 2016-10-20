//
//  HomePageController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit
import Alamofire

class BumpHomePageController: UIViewController {

    @IBOutlet var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        navigationController?.navigationBar.barTintColor = UIColor(red: 0.141, green: 0.620, blue: 0.918, alpha: 1.00)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 28.0)!]
        self.navigationItem.title = "Bump"

        username.text = currentUser
        
        getJson()
        
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            getJson()
        }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
