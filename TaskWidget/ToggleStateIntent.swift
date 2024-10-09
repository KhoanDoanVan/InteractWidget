//
//  ToggleStateIntent.swift
//  InteractWidget
//
//  Created by Đoàn Văn Khoan on 9/10/24.
//

import SwiftUI
import AppIntents

struct ToggleStateIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Toggle Task State"
    
    /// Parameters
    @Parameter(title: "Task ID")
    var id: String
    
    init() {
        
    }
    
    init(id: String) {
        self.id = id
    }
    
    func perform() async throws -> some IntentResult {
        
        /// Update your database here
        if let index = TaskDataModel.shared.tasks.firstIndex(where: {
            $0.id == id
        }) {
            TaskDataModel.shared.tasks[index].isCompleted.toggle()
        }
        
        return .result()
    }
}
