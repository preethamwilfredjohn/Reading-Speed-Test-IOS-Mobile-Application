//
//  FirstViewController.swift
//  WordSpeedTest
//
//  Created by OS X on 4/12/18.
//  Copyright © 2018 Will. All rights reserved.
//

import UIKit
import CoreData
var userNameSpeedTab : String = ""
class SpeedTest: UIViewController {

    @IBOutlet weak var words: UILabel!
    @IBOutlet weak var timeInter: UITextField!
    @IBOutlet weak var userName: UITextField!
    var firstTime = true
    var timerScheduled = false
    var timer = Timer()
    var timeInterval : Double = 0.0
    var arrayData = [String]()
    var index = 0
    let boldFont = UIFont(name: "Avenir-Heavy", size: 14.0)!
    

    @IBAction func reset(_ sender: Any) {
        timer.invalidate()
        index = 0
        words.text = ""
        timerScheduled = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userName.resignFirstResponder()
        self.view.endEditing(true)
    }
    @IBAction func start(_ sender: Any) {
        if userName.text!.isEmpty && timeInter.text!.isEmpty{

            let alert = UIAlertController(title: "My Alert", message: "Please enter User Name and Words Per Minute", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let date = Date()
        userNameSpeedTab = self.userName.text!
        timeInterval = 60.0 / Double(self.timeInter.text!)!
        let timeI = timeInter.text!
            if(!timerScheduled){
                timerScheduled = true
                if(firstTime){
                    sleep(UInt32(1))
                    firstTime = false
                }else{
                    if delay == 0 {
                        sleep(UInt32(1))
                    }
                    else{
                        sleep(delay)
                    }
                }
                timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(SpeedTest.updateWords), userInfo: nil, repeats: true)
                RunLoop.main.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
                timer.fire()
            }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let user =  NSEntityDescription.insertNewObject(forEntityName: "Data", into: context)
        user.setValue(timeI, forKey: "speed1")
        user.setValue(userNameSpeedTab, forKey: "users")
        user.setValue(date, forKey: "date")
        
        do{
            try context.save()
                print("SAVED")
        }
        catch{
            
        }
        }
    @objc func updateWords(){
        let filePath = Bundle.main.path(forResource: "data", ofType: "txt")
        var readData = ""
        
        do{
            readData = try String(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
            arrayData = readData.components(separatedBy: " ")
            var word: String
            word = arrayData[index]
            let initialString = word
            let attributedString = NSMutableAttributedString(string: initialString)
            let x = (initialString.count - 1) / 2
            let ra = NSRange(location: x,length:1)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow, range: ra)
            words.attributedText = attributedString
                index += 1
        }
        catch let error as NSError {
            print("Failed reading from URL: \(String(describing: filePath)), Error: " + error.localizedDescription)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        userName.becomeFirstResponder()
        super.viewDidLoad()
        timeInter.keyboardType = .numberPad
        if wordsPerMin != 0  {
        timeInter.text = "\(wordsPerMin)"
        }
        if uN != "" {
            userName.text = uN
        }
    }
}

