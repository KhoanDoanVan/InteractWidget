//
//  TaskModel.swift
//  InteractWidget
//
//  Created by Đoàn Văn Khoan on 9/10/24.
//

import Foundation

struct TaskModel: Identifiable {
    var id: String = UUID().uuidString
    var taskTitle: String
    var isCompleted: Bool = false
}

/// Sample Data Model
class TaskDataModel {
    static let shared = TaskDataModel()
    
    var tasks: [TaskModel] = [
        .init(taskTitle: "Record video"),
        .init(taskTitle: "Take shower"),
        .init(taskTitle: "Watching tv")
    ]
}
