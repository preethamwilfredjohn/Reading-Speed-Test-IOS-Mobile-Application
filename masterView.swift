//
//  masterView.swift
//  WordSpeedTest
//
//  Created by OS X on 4/21/18.
//  Copyright © 2018 Will. All rights reserved.
//

import UIKit
import CoreData

class masterView: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var speedL1: UILabel!
    @IBOutlet weak var speedL2: UILabel!
    @IBOutlet weak var speedL3: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NumberOfTries: UILabel!
    
    var userArray:[Data] = []
    var currentTryCount:[Data] = []
    var speed:[Data] = []

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let fetchedUser = userArray[indexPath.row]
        cell.textLabel?.text = fetchedUser.users! + " Speed: " + fetchedUser.speed1!
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.fetchData()
        self.tableView.reloadData()
        if uN == ""{
        userName.text = userNameSpeedTab
        }
        else{
            userName.text = uN
        }
        let user = userName.text!
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let tryCount = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
        tryCount.returnsObjectsAsFaults = false
        tryCount.predicate = NSPredicate(format: "users == %@", user)
        do{
            currentTryCount = try context.fetch(tryCount) as! [Data]
            NumberOfTries.text = "\(currentTryCount.count)"
        }
        catch{
            
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = NSPredicate(format: "users == %@", user)
        request.fetchOffset = 0
        request.fetchLimit = 3
        do{
            
            speed = try context.fetch(request) as! [Data]
            print(speed)
            if speed.count == 0{
                speedL1.text! = ""
            }
            else{
                let speed1D = speed[0]
                speedL1.text! = "\(String(describing: speed1D.speed1!))"
            }
            if speed.count < 2{
                speedL2.text! = ""
            }
            else{
                let speed2D = speed[1]
                speedL2.text! = "\(String(describing: speed2D.speed1!))"
            }
            if speed.count < 3{
                speedL3.text! = ""
            }
            else{
                let speed3D = speed[2]
                speedL3.text! = "\(String(describing: speed3D.speed1!))"
            }
        }
        catch{
            
        }
    }
    func fetchData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
        request1.returnsObjectsAsFaults = false
        request1.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do{
            userArray = try context.fetch(request1) as! [Data]
        }
        catch{
            
        }
    }
}
