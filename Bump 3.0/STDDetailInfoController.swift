//
//  STDDetailInfoController.swift
//  Bump 3.0
//
//  Created by alden lamp on 9/13/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit

class STDDetailInfoController: UINavigationController {

    @IBOutlet var appearDateAfterLabel: UILabel!
    
    @IBOutlet var symptoms: UITextView!
    @IBOutlet var treatment: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor();
        
        
        self.navigationItem.title = currentSTDInfo
    }

}
