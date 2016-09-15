//
//  AddPartnerController.swift
//  Bump 3.0
//
//  Created by alden lamp on 8/28/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit

var qrcodeImage: CIImage!

class BumpAddPartnerController: UIViewController {

    @IBOutlet var usernameText: UILabel!
    @IBOutlet var qrImage: UIImageView!
    @IBOutlet var userNameOfPartner: UITextField!
    
    @IBOutlet var scanCodeButton: UIButton!
    @IBOutlet var addUserButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        usernameText.text = currentUser

        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor();
        self.navigationController!.navigationBar.topItem!.title = "Bump"
        
        self.navigationItem.title = "Add Partner"
        
        let data = currentUser.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter!.setValue(data, forKey: "inputMessage")
        filter!.setValue("Q", forKey: "inputCorrectionLevel")
        
        qrcodeImage = filter!.outputImage
        
        
        qrImage.image = UIImage(CIImage: qrcodeImage)
        
        
        userNameOfPartner.layer.borderColor = UIColor(red: 0.141, green: 0.620, blue: 0.918, alpha: 1.00).CGColor
        userNameOfPartner.layer.borderWidth = 1.5
        userNameOfPartner.attributedPlaceholder = NSAttributedString(string: "Username Of Partner", attributes: [NSForegroundColorAttributeName: UIColor(red: 0.141, green: 0.620, blue: 0.918, alpha: 1.00)])
        
        addUserButton.backgroundColor = UIColor(red: 0.141, green: 0.620, blue: 0.918, alpha: 1.00)
        addUserButton.titleLabel?.textColor = UIColor.whiteColor()
        addUserButton.titleLabel?.font = UIFont(name: "Avenir_Medium", size: 20)
        scanCodeButton.titleLabel?.font = UIFont(name: "Avenir_Medium", size: 20)
        scanCodeButton.backgroundColor = UIColor(red: 0.141, green: 0.620, blue: 0.918, alpha: 1.00)
    }

}
