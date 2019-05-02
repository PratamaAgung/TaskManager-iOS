//
//  TaskModel.swift
//  TaskManager
//
//  Created by JojoBandung on 5/1/19.
//  Copyright © 2019 JojoBandung. All rights reserved.
//

import Foundation

enum TaskStatus {
    case done, pending, over, on_progress
}

class TaskDataModel {
    let user_id : String
    var taskName : String
    var createdDate : Date
    var willDoDate : Date?
    var finishedDate : Date?
    var status: TaskStatus
    
    init(user_id: String, taskName: String) {
        self.user_id = user_id
        self.taskName = taskName
        self.createdDate = Date()
        self.status = TaskStatus.on_progress
    }
}
