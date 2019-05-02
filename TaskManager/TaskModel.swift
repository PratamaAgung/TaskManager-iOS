//
//  TaskModel.swift
//  TaskManager
//
//  Created by JojoBandung on 5/1/19.
//  Copyright © 2019 JojoBandung. All rights reserved.
//

import Foundation

enum TaskStatus : Int {
    case pending = 0
    case onProgress = 1
    case done = 2
    case blocked = 3
}

class TaskDataModel {
    var objectID : URL?
    let userID : String
    var taskName : String
    var createdDate : Date
    var willDoDate : Date?
    var finishedDate : Date?
    var status: TaskStatus
    
    init() {
        self.userID = ""
        self.taskName = ""
        self.createdDate = Date()
        self.status = TaskStatus.pending
    }
    
    init(user_id: String, taskName: String) {
        self.userID = user_id
        self.taskName = taskName
        self.createdDate = Date()
        self.status = TaskStatus.pending
    }
    
    init(user_id: String, taskName: String, createdDate: Date, status: TaskStatus) {
        self.userID = user_id
        self.taskName = taskName
        self.createdDate = createdDate
        self.status = status
    }
}
