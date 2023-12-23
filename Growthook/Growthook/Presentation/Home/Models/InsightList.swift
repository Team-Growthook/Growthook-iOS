//
//  InsightListModel.swift
//  Growthook
//
//  Created by KJ on 11/12/23.
//

import UIKit

enum InsightStatus {
    case light
    case dark
    case lock
}

struct InsightList {
    let InsightStatus: InsightStatus
    let scrapStatus: Bool
    let title: String
    let dueTime: String
}

extension InsightList {
    
    static func insightListDummyData() -> [InsightList] {
        return [
            InsightList(InsightStatus: .light, scrapStatus: true, title: "안녕하세요", dueTime: "00일 후 잠금"),
            InsightList(InsightStatus: .light, scrapStatus: false, title: "쑥쑥이들은 최고다.", dueTime: "00일 후 잠금"),
            InsightList(InsightStatus: .light, scrapStatus: false, title: "iOS 짱이당", dueTime: "00일 후 잠금"),
            InsightList(InsightStatus: .light, scrapStatus: false, title: "민주 화이팅", dueTime: "00일 후 잠금"),
            InsightList(InsightStatus: .light, scrapStatus: false, title: "성우오빠 화이팅", dueTime: "00일 후 잠금"),
            InsightList(InsightStatus: .lock, scrapStatus: false, title: "규보오빠 화이팅", dueTime: "00일 후 잠금"),
            InsightList(InsightStatus: .dark, scrapStatus: true, title: "권정 화이팅", dueTime: "00일 후 잠금"),
            InsightList(InsightStatus: .lock, scrapStatus: false, title: "개발 언제끝남? ㅋㅋ", dueTime: "00일 후 잠금"),
            InsightList(InsightStatus: .dark, scrapStatus: true, title: "진짜 언제 끝남?", dueTime: "00일 후 잠금"),
            InsightList(InsightStatus: .dark, scrapStatus: false, title: "왜 안끝남?", dueTime: "00일 후 잠금"),
            InsightList(InsightStatus: .dark, scrapStatus: true, title: "서버는 붙이는거 무섭다..", dueTime: "00일 후 잠금")
        ]
    }
}
