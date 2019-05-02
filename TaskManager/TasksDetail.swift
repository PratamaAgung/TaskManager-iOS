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
    var task_id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskNameLabel.text = task_id
        // Do any additional setup after loading the view.
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
