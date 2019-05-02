//
//  TaskCoreDataWorker.swift
//  TaskManager
//
//  Created by JojoBandung on 5/2/19.
//  Copyright © 2019 JojoBandung. All rights reserved.
//

import Foundation
import CoreData

class TaskCoreDataWorker {
    var dataContext : NSManagedObjectContext!
    var persistenStoreCoor : NSPersistentStoreCoordinator
    
    init(appDelegate: AppDelegate){
        self.dataContext = appDelegate.persistentContainer.viewContext
        self.persistenStoreCoor = appDelegate.persistentContainer.persistentStoreCoordinator
        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
//        fetchRequest.returnsObjectsAsFaults = false
//
//        do
//        {
//            let results = try self.dataContext.fetch(fetchRequest)
//            for managedObject in results
//            {
//                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
//                print(managedObjectData.value(forKey: "taskName") as! String)
//                self.dataContext.delete(managedObjectData)
//                try self.dataContext.save()
//            }
//        } catch let error as NSError {
//            print("Detele all data")
//        }
    }
    
    func convertDataObjectToTask(data: NSManagedObject) -> TaskDataModel {
        let taskName = data.value(forKey: "taskName") as? String ?? ""
        let createdDate = data.value(forKey: "createdDate") as? Date
        let status = TaskStatus(rawValue: data.value(forKey: "status") as? Int ?? 0)!
        let finishDate = data.value(forKey: "finishDate") as? Date
        let willDoDate = data.value(forKey: "willDoDate") as? Date ?? nil
        let userId = data.value(forKey: "userId") as? String ?? ""
        
        let task = TaskDataModel(user_id: userId, taskName: taskName)
        task.objectID = data.objectID.uriRepresentation()
        task.status = status
        if (createdDate != nil) {
            task.createdDate = createdDate!
        }
        if (finishDate != nil) {
            task.finishedDate = finishDate!
        }
        if (willDoDate != nil) {
            task.willDoDate = willDoDate!
        }
        
        return task
    }
    
    func getTasksForUser(userId: String) -> [TaskDataModel] {
        var userTasks = [TaskDataModel]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        let predicate = NSPredicate(format: "userId == %@", userId)
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        do {
            let result = try self.dataContext.fetch(request)
            for data in result as! [NSManagedObject] {
                let task = convertDataObjectToTask(data: data)
                userTasks.append(task)
            }
            
        } catch {
            print("Failed catching data")
        }
        
        return userTasks
    }
    
    func saveNewTask(task: TaskDataModel) -> Bool{
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: self.dataContext)
        let newUser = NSManagedObject(entity: entity!, insertInto: self.dataContext)
        newUser.setValue(task.taskName, forKey: "taskName")
        newUser.setValue(task.userID, forKey: "userId")
        newUser.setValue(task.createdDate, forKey: "createdDate")
        newUser.setValue(task.status.rawValue, forKey: "status")
        
        do {
            try self.dataContext.save()
            return true
        } catch {
            print("Failed saving")
            return false
        }
    }
    
    func getTaskDetail(objectID : URL) -> TaskDataModel {
        guard let moid = self.persistenStoreCoor.managedObjectID(forURIRepresentation: objectID) else { return TaskDataModel() }
        let data = self.dataContext.object(with: moid)
        let task = convertDataObjectToTask(data: data)
        
        return task
    }
}
