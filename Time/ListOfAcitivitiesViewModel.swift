//
//  DailyTimeViewModel.swift
//  Time
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 10/06/23.
//

import Foundation
import RealmSwift

class ListOfAcitivitiesViewModel: ObservableObject {
    @Published var activities = Realm.shared().objects(Activity.self).sorted(by: \.start, ascending: false)
    @Published var newActivityName = ""
    
    // MARK: Intent(s)
    
    func startActivity() {
        self.objectWillChange.send()
        let newActivity = Activity()
        newActivity.name = newActivityName
        newActivity.start = Date.now.millisecondsSince1970
        Realm.writeWithTry { realm in
            realm.add(newActivity)
        }
        newActivityName = ""
    }
    
    func stopActivity() {
        self.objectWillChange.send()
        activities[0].write { thawedObj, thawedRealm in
            thawedObj.end = Date.now.millisecondsSince1970
        }
    }
    
    func delete(_ activity: Activity) {
        self.objectWillChange.send()
        activity.write { thawedObj, thawedRealm in
            thawedRealm.delete(thawedObj)
        }
    }
}

class Activity: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var start = Date.now.millisecondsSince1970
    @Persisted var end: Int64 = 0
    
    var duration: Int64 {
        if end == 0 {
            return 0
        } else {
            return (end - start) / 1000 / 60
        }
    }
    
    var hasEnded: Bool {
        end != 0
    }
    
    func write(_ callback: (Activity, Realm) -> Void) {
        guard let thawedObj = self.thaw() else { return }
        assert(thawedObj.isFrozen == false)
        guard let thawedRealm = thawedObj.realm else { return }
        do {
            try thawedRealm.write {
                callback(thawedObj, thawedRealm)
            }
        } catch let error {
            print(error)
        }
    }
}
