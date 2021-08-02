//
//  TaskList.swift
//  ModernToDoList
//
//  Created by Евгений Березенцев on 01.08.2021.
//

import Foundation

struct TaskList: Hashable {
    let name: String
    var tasks: [Task]?
    
}

struct Task: Hashable {
    let name: String
    var isDone: Bool
}

//extension TaskList {
//
//    static func getTaskLists() -> [TaskList] {
//        [TaskList(name: "Current", tasks: [Task(name: "MakeAnApp", isDone: false)])]
//    }
//}
