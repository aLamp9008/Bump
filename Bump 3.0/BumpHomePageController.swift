//
//  HomePageController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit

class BumpHomePageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        navigationController?.navigationBar.barTintColor = UIColor(red: 0.141, green: 0.620, blue: 0.918, alpha: 1.00)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 28.0)!]
        self.navigationItem.title = "Bump"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
