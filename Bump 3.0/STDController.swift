//
//  STDController.swift
//  
//
//  Created by alden lamp on 9/16/16.
//
//

import UIKit

class STDController: UIViewController {

    @IBOutlet var daysAfter: UILabel!
    
    @IBOutlet var symptoms: UITextView!
    
    @IBOutlet var treatment: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: fotSize(currentSTDInfo.characters.count)]
        
    self.navigationController!.navigationBar.topItem!.title = "STD Info"
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor();
        
        self.navigationItem.title = currentSTDInfo
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.Bordered, target: self, action: "back")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        var genderSomething : Int {
            get{
                if (currentGender){
                    return 2
                }else{
                    return 1
                }
            }
            set{
                return
            }
        }
        daysAfter.text = STDDict[currentSTDInfo]![0]
        symptoms.text = STDDict[currentSTDInfo]![genderSomething]
        treatment.text = STDDict[currentSTDInfo]![3]
        
        
        
    }
    
    func back(){
        performSegueWithIdentifier("home", sender: nil)
    }

    func fotSize(num : Int) -> UIFont{
        var fontSize = 28.0
        if num > 26 {
            fontSize = 15.0
        }else if num > 20{
            fontSize = 17.0
        }else{
            fontSize = 28.0
        }
      var font = UIFont(name: "Avenir-Medium", size: CGFloat(fontSize))!
     return font
    }
     
 
}

