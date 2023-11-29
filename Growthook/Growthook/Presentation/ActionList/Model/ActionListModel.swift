//
//  ActionListModel.swift
//  Growthook
//
//  Created by 천성우 on 11/18/23.
//

import UIKit

enum ActionListStatus {
    case scrap
    case unScrap
}

struct ActionListModel {
    let scrapStatus: ActionListStatus
    let title: String
}

extension ActionListModel {
    static func actionListModelDummyData() -> [ActionListModel] {
        return [
            ActionListModel(scrapStatus: .unScrap, title: "북극성 지표를 적용해야한다"),
            ActionListModel(scrapStatus: .unScrap, title: "목적과 이루어내고 싶은 것 확실하게 하기 (PMF)"),
            ActionListModel(scrapStatus: .unScrap, title: "쑥쑥이들이랑 같이 새벽 1시에 불닭을 끓여 갈비 만두와 함께 먹기"),
            ActionListModel(scrapStatus: .scrap, title: "RxSwift는 너무 어렵고 나는 눈물이 난다"),
            ActionListModel(scrapStatus: .scrap, title: "MVVM? 그냥 날 죽여라"),
        ]
    }
}

struct CompleteActionListModel {
    let scrapStatus: ActionListStatus
    let title: String
}

extension CompleteActionListModel {
    static func completeActionListModelDummyData() -> [CompleteActionListModel] {
        return [
            CompleteActionListModel(scrapStatus: .unScrap, title: "북극성 지표를 적용해야한다"),
            CompleteActionListModel(scrapStatus: .scrap, title: "MVVM? 그냥 날 죽여라"),
        ]
    }
}
