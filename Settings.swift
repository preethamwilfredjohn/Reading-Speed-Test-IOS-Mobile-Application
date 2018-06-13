//
//  Settings.swift
//  WordSpeedTest
//
//  Created by OS X on 4/21/18.
//  Copyright © 2018 Will. All rights reserved.
//

import UIKit
import CoreData

var wordsPerMin : Int = 0
var delay : UInt32 = 0
var uN : String = ""
class Settings: UIViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var wpm: UITextField!
    @IBOutlet weak var delayStart: UITextField!
    @IBOutlet weak var userName: UITextField!

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        wpm.resignFirstResponder()
        self.view.endEditing(true)
    }
    @IBAction func updateData(_ sender: Any) {
        if userName.text!.isEmpty{
            let alert = UIAlertController(title: "My Alert", message: "Please enter User Name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        wordsPerMin = Int(wpm.text!)!
        delay = UInt32(delayStart.text!)!
        uN = userName.text!
        let alert1 = UIAlertController(title: "My Alert", message: "You can start Testing under Speed Test Tab", preferredStyle: .alert)
        alert1.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert1, animated: true, completion: nil)
        return
    }
    override func viewDidAppear(_ animated: Bool) {
        wpm.becomeFirstResponder()
        let wpmInitial = 60
        let delayInitial = 0
        wpm.text = "\(wpmInitial)"
        delayStart.text = "\(delayInitial)"
        userName.text = userNameSpeedTab
        wpm.keyboardType = .numberPad
        delayStart.keyboardType = .numberPad
        super.viewDidLoad()        
    }
}
