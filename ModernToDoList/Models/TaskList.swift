//
//  TaskList.swift
//  ModernToDoList
//
//  Created by Евгений Березенцев on 01.08.2021.
//

import Foundation

struct TaskList: Hashable {
    let idetifier = UUID()
    var name: String
    var tasks: [Task]?
    
}

struct Task: Hashable {
    let id = UUID()
    var name: String
    var isDone: Bool
}

extension TaskList {
    
    static func getTaskLists() -> [TaskList] {
        [TaskList(name: "Current", tasks: [Task(name: "MakeAnApp", isDone: true)]),
         TaskList(name: "Week", tasks: [Task(name: "Go to shop", isDone: true),
                                        Task(name: "Watch movie", isDone: false)]),
         TaskList(name: "Month", tasks: [Task(name: "Start new project", isDone: false)])
        ]
    }
}
