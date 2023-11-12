//
//  InsightListModel.swift
//  Growthook
//
//  Created by KJ on 11/12/23.
//

import UIKit

enum InsightStatus {
    case scrapLight
    case light
    case lock
    case scrapDark
    case dark
}

struct InsightListModel {
    let scrapStatus: InsightStatus
    let title: String
    let dueTime: String
}

extension InsightListModel {
    
    static func insightListDummyData() -> [InsightListModel] {
        return [
            InsightListModel(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightListModel(scrapStatus: .scrapDark, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightListModel(scrapStatus: .scrapDark, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightListModel(scrapStatus: .lock, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightListModel(scrapStatus: .light, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightListModel(scrapStatus: .dark, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightListModel(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightListModel(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금")
        ]
    }
}
