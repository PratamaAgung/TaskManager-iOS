//
//  TasksDetail.swift
//  TaskManager
//
//  Created by JojoBandung on 4/30/19.
//  Copyright © 2019 JojoBandung. All rights reserved.
//

import UIKit

class TasksDetail: UIViewController {
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var willDoLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var taskId: URL?
    var dataWorker: TaskCoreDataWorker?
    var task: TaskDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.dataWorker = TaskCoreDataWorker(appDelegate: appDelegate)
        self.task = self.dataWorker?.getTaskDetail(objectID: self.taskId!)
        
        taskNameLabel.text = self.task?.taskName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        createdLabel.text = dateFormatter.string(from: self.task!.createdDate)
        
        switch self.task!.status {
        case .blocked:
            statusLabel.text = "Blocked"
        case .done:
            statusLabel.text = "Done"
        case .onProgress:
            statusLabel.text = "On Progress"
        case .pending:
            statusLabel.text = "Pending"
        }
        
        if self.task!.finishedDate != nil {
            finishLabel.text = dateFormatter.string(from: self.task!.finishedDate!)
        } else {
            finishLabel.text = "-"
        }
        
        if self.task!.willDoDate != nil {
            willDoLabel.text = dateFormatter.string(from: self.task!.willDoDate!)
        } else {
            willDoLabel.text = "-"
        }
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
