//
//  STDInfoController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit

var STDDict : [String : [String]] = ["Chancroid" :["appears 4-10 days after infection", "Open sores, usually on the penis, rectum, and vulva — especially around the opening to the vagina. Sores may produce pus and be painful. \n Swollen glands in the groin", "Open sores, usually on the penis, rectum, and vulva — especially around the opening to the vagina. Sores may produce pus and be painful. \n Swollen glands in the groin.", "Chancroid is easily treated with antibiotics. Please consult your doctor if you are experience any of the symptoms above."], "Chlamydia" : []]
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
