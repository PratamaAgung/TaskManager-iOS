//
//  TasksViewController.swift
//  TaskManager
//
//  Created by JojoBandung on 4/30/19.
//  Copyright © 2019 JojoBandung. All rights reserved.
//

import UIKit
import CoreData

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var taskList: UITableView!
    var tasks = [String]()
    var dataContext : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.dataContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        request.returnsObjectsAsFaults = false
        do {
            let result = try self.dataContext.fetch(request)
            for data in result as! [NSManagedObject] {
                tasks.append(data.value(forKey: "taskName") as! String)
            }
            
        } catch {
            print("Failed catching data")
        }
        
        self.taskList.delegate = self
        self.taskList.dataSource = self
        
        let nib = UINib.init(nibName: "TasksListCell", bundle: nil)
        self.taskList.register(nib, forCellReuseIdentifier: "TasksListCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask(sender:)))
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksListCell", for: indexPath) as! TasksListCell
        
        cell.taskName.text = tasks[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath) as? TasksListCell) != nil {
            let taskDetailVC = TasksDetail()
            taskDetailVC.task_id = tasks[indexPath.row]
            self.navigationController?.pushViewController(taskDetailVC, animated: true)
        }
    }
    
    // MARK: - Data Maintenance
    @objc func addTask(sender: UIBarButtonItem){
        let alert = UIAlertController(title: "Task Name", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your task name here..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let name = alert.textFields?.first?.text {
                let entity = NSEntityDescription.entity(forEntityName: "Task", in: self.dataContext)
                let newUser = NSManagedObject(entity: entity!, insertInto: self.dataContext)
                newUser.setValue(name, forKey: "taskName")
                self.tasks.append(name)
                do {
                    try self.dataContext.save()
                    self.taskList.reloadData()
                } catch {
                    print("Failed saving")
                }
            }
        }))
        
        self.present(alert, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
