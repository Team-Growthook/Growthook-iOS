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

struct InsightList {
    let scrapStatus: InsightStatus
    let title: String
    let dueTime: String
}

extension InsightList {
    
    static func insightListDummyData() -> [InsightList] {
        return [
            InsightList(scrapStatus: .lock, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(scrapStatus: .scrapLight, title: "쑥쑦이들은 최고다.", dueTime: "00일 후 잠금")
        ]
    }
}
