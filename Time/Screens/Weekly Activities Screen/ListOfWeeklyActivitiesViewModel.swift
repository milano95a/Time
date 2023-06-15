//
//  ListOfWeeklyActivitiesViewModel.swift
//  Time
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 15/06/23.
//

import Foundation
import RealmSwift

class ListOfWeeklyActivitiesViewModel: ObservableObject {
    @Published var items = [WeeklyActivities]()
    
    init() {
//        self.objectWillChange.send()
        let acitivities = try! Realm().objects(Activity.self)
        var activitiesDict = [String: WeeklyActivities]()
        for activity in acitivities {
            let date = Date(milliseconds: activity.end)
            let year = date.year
            let week = date.week
            let key = "\(week) \(year)"
            
            if activitiesDict[key] == nil {
                var weeklyActivity = WeeklyActivities(date: key)
                weeklyActivity.activityDurationByType[activity.type]! += Int(activity.duration)
                activitiesDict[key] = weeklyActivity
            } else {
                activitiesDict[key]!.activityDurationByType[activity.type]! += Int(activity.duration)
            }
        }
        items = Array(activitiesDict.values)
    }
}

struct WeeklyActivities: Identifiable {
    var id = UUID().uuidString
    var date: String
    var activityDurationByType: [ActivityType: Int]
    
    init(date: String) {
        self.date = date
        
        var activityDurationByType = [ActivityType: Int]()
        for type in ActivityType.allCases {
            activityDurationByType[type] = 0
        }
        self.activityDurationByType = activityDurationByType
    }
}


extension Date {
    var year: Int {
        Calendar.current.dateComponents([.year], from: self).year!
    }
    
    var week: Int {
        Calendar.current.dateComponents([.weekOfYear], from: self).weekOfYear!
    }
}
