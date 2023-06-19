//
//  Extensions.swift
//  Time
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 10/06/23.
//

import SwiftUI
import RealmSwift

extension Realm {
    // TODO: use this shared instance everywhere
    static func shared() -> Realm {
        let configuration = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = configuration
        let realm = try! Realm()
        return realm
    }
    
    static func writeWithTry(_ callback: (Realm) -> Void ) {
        do {
            let realm = try Realm()
            try realm.write {
                callback(realm)
            }
        } catch let error {
            print(error)
        }
    }
    
    static func deleteWithTry(_ object: Object) {
        Realm.writeWithTry { realm in
            realm.delete(object)
        }
    }
    
    static func addWithTry(_ object: Object) {
        Realm.writeWithTry { realm in
            realm.add(object)
        }
    }
    
    static func deleteAll() {
        Realm.writeWithTry { realm in
            realm.deleteAll()
        }
    }
    
    static func fetchRequest<Element: RealmFetchable>(_ predicate: NSPredicate) -> Results<Element> {
        return Realm.shared().objects(Element.self)
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

extension Color {
    static var blue1: Color {
        Color(red: 49/255, green: 91/255, blue: 154/255)
    }
    static var red1: Color {
        Color(red: 204/255, green: 91/255, blue: 91/255)
    }
    static var red2: Color {
        Color(red: 195/255, green: 60/255, blue: 60/255)
    }
    static var black1: Color {
        Color(red: 55/255, green: 55/255, blue: 55/255)
    }
    static var blue2: Color {
        Color(red: 80/255, green: 155/255, blue: 197/255)
    }
    static var green1: Color {
        Color(red: 118/255, green: 175/255, blue: 71/255)
    }
    static var green2: Color {
        Color(red: 98/255, green: 145/255, blue: 59/255)
    }

    static var purple1: Color {
        Color(red: 115/255, green: 66/255, blue: 164/255)
    }

}
