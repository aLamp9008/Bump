//
//  STDInfoController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit

var currentSTDInfo : String = ""

class BumpSTDInfoController: UIViewController {

    @IBOutlet var tableVeiw: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor();
        self.navigationController!.navigationBar.topItem!.title = "Bump"
        
        self.navigationItem.title = "STD Info"
    }


    
    

}
