//
//  InsightModel.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/22/23.
//

import Foundation

struct InsightModel {
    let name: String
    let insight: String
    let date: String
    let dDay: String
    let memo: String
}

extension InsightModel {
    static func dummy() -> InsightModel {
        return InsightModel(name: "괵괵",
                            insight: "야식에 불닭과 만두의 조합 좋다",
                            date: "2023.11.08",
                            dDay: "D-21",
                            memo: "앱잼 합숙 기간 새벽에 먹으면 더욱 효과적으로 행복할 수 있다. 현 그로쑥 전 퍼즐링이 합숙할 때도 먹었는데 진짜 행복했다 아무래도 함께하는 사람들이 좋으니까.행복했겠지 아무래도 그렇지 암암 앱잼 합숙 기간 새벽에 먹으면 더욱 효과적으로 행복할 수 있다. 현 그로쑥 전 퍼즐링이 합숙할 때도 먹었는데 진짜 행복했다 아무래도 함께하는 사람들이 좋으니까.행복했겠지 아무래도 그렇지 암암")
    }
}

