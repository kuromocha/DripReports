//
//  Extentions.swift
//  DripReports
//
//  Created by 嘉山正太郎 on 2020/10/25.
//

import UIKit

// Date の拡張をしている
extension Date{
    // 表示用の文字列に変換する関数
    func toDisplayString() -> String {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        return f.string(from: self)
    }
}

extension Int{
    func toString() -> String {
        return String(self)
    }
}


