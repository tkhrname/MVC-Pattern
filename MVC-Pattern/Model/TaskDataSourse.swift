//
//  TaskDataSourse.swift
//  MVC-Pattern
//
//  Created by 渡邊丈洋 on 2019/03/11.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import Foundation

class TaskDataSourse: NSObject {
    private var tasks = [Task]()
    // UserDefaultsから保存したデータを取得
    func loadData() {
        let userDefaults = UserDefaults.standard
        guard let taskDictionaries = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
        for dic in taskDictionaries {
            let task = Task(from: dic)
            self.tasks.append(task)
        }
    }
    
    //
    func save(task: Task) {
        self.tasks.append(task)
        var taskDictionaries = [[String: Any]]()
        for t in self.tasks {
            let taskDictionary: [String : Any] = ["text": t.text, "deadline": t.deadline]
            taskDictionaries.append(taskDictionary)
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(taskDictionaries, forKey: "tasks")
        userDefaults.synchronize()
    }
    
    func count() -> Int {
        return self.tasks.count
    }
    
    func data(at index: Int) -> Task? {
        if self.tasks.count > index {
            return tasks[index]
        }
        return nil
    }
}
