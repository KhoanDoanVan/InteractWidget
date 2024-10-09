//
//  TaskWidget.swift
//  TaskWidget
//
//  Created by Đoàn Văn Khoan on 9/10/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (TaskEntry) -> ()) {
        let entry = TaskEntry(lastThreeTasks: Array(TaskDataModel.shared.tasks.prefix(3)))
        completion(entry)
    }
    
    func placeholder(in context: Context) -> TaskEntry {
        /// Customize Your Placeholder View Here
        TaskEntry(lastThreeTasks: Array(TaskDataModel.shared.tasks.prefix(3)))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        /// Fetch data here
        let lastestTasks = Array(TaskDataModel.shared.tasks.prefix(3))
        let lastestEntries = [TaskEntry(lastThreeTasks: lastestTasks)]
        let timeline = Timeline(entries: lastestEntries, policy: .atEnd)
        completion(timeline)
    }
}

struct TaskEntry: TimelineEntry {
    let date: Date = .now
    var lastThreeTasks: [TaskModel]
}

struct TaskWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Task's")
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 6) {
                if entry.lastThreeTasks.isEmpty {
                    Text("No Task's Found")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ForEach(entry.lastThreeTasks.sorted{
                        !$0.isCompleted && $1.isCompleted
                    }) { task in
                        HStack(spacing: 6) {
                            Button(intent: ToggleStateIntent(id: task.id)) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(.blue)
                            }
                            .buttonStyle(.plain)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(task.taskTitle)
                                    .textScale(.secondary)
                                    .lineLimit(1)
                                    .strikethrough(task.isCompleted, pattern: .solid, color: .primary)
                                
                                Divider()
                            }
                        }
                                                
                        if task.id != entry.lastThreeTasks.last?.id {
                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct TaskWidget: Widget {
    let kind: String = "TaskWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TaskWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Task Widget")
        .description("This is an example of interactive widget.")
    }
}

#Preview(as: .systemSmall) {
    TaskWidget()
} timeline: {
    TaskEntry(lastThreeTasks: TaskDataModel.shared.tasks)
}
