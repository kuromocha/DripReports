//
//  RealmReport.swift
//  DripReports
//
//  Created by 嘉山正太郎 on 2020/10/16.
//

import UIKit
import RealmSwift

class RealmReport: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var createdAt = Date()
    @objc dynamic var waterAmount = 0
    @objc dynamic var beansAmount = 0.0
    @objc dynamic var dripMinutes = 0
    @objc dynamic var dripSeconds = 0
    @objc dynamic var country = ""
    @objc dynamic var comment = ""
    @objc dynamic var flavorText = ""
    @objc dynamic var roasterName = ""
    @objc dynamic var beansProcess = ""
//    @objc dynamic var productionFarm = ""
//    @objc dynamic var roastingStatus = ""
//    @objc dynamic var extractingMethod = ""
//    @objc dynamic var grainSize = ""
//    @objc dynamic var favorite = false
//    @objc dynamic var rating = 0
//    @objc dynamic var waterKind = ""
//    @objc dynamic var roastedTerm = 0 // 焙煎日から何日か
    
    func setNewId() {
        let realm = try! Realm()
        self.id = (realm.objects(type(of: self).self).sorted(byKeyPath: "id", ascending: false).first?.id ?? 0) + 1
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func getTimeString() -> String{
        return self.dripMinutes.toString() + "min" + self.dripSeconds.toString() + "s"
    }
}
