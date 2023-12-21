//
//  InsightsViewModel.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 11/12/23.
//

import UIKit

import RxCocoa
import RxSwift

/// Still Working... 🚧
///
///
struct InsightCaveModel {
    var caveId: Int
    var caveTitle: String
}

struct InsightPeriodModel {
    var periodMonthAsInteger: Int
    var periodTitle: String
}

protocol InsightsViewModelInput {
    func selectCaveToAdd(of cave: InsightCaveModel)
    func selectGoalPeriodToAdd(of period: InsightPeriodModel)
    func resetSelectedCave()
}

protocol InsightsViewModelOutput {
    var myOwnCaves: Observable<[InsightCaveModel]> { get }
    var selectedCave: BehaviorRelay<InsightCaveModel?> { get }
    var availablePeriodList: [InsightPeriodModel] { get }
    var selectedPeriod: BehaviorRelay<InsightPeriodModel?> { get }
}

protocol InsightsViewModelType {
    var inputs: InsightsViewModelInput { get }
    var outputs: InsightsViewModelOutput { get }
}

final class InsightsViewModel: InsightsViewModelOutput, InsightsViewModelInput, InsightsViewModelType {
    
    var availablePeriodList: [InsightPeriodModel]
    var myOwnCaves: Observable<[InsightCaveModel]>
    var selectedCave = BehaviorRelay<InsightCaveModel?>(value: nil)
    var selectedPeriod = BehaviorRelay<InsightPeriodModel?>(value: nil)
    
    var inputs: InsightsViewModelInput { return self }
    var outputs: InsightsViewModelOutput { return self }
    
    init() {
        myOwnCaves = Observable.just([
            .init(caveId: 0, caveTitle: "Cave11"),
            .init(caveId: 1, caveTitle: "Cave12"),
            .init(caveId: 2, caveTitle: "Cave13"),
            .init(caveId: 3, caveTitle: "Cave14"),
            .init(caveId: 4, caveTitle: "Cave15"),
            .init(caveId: 5, caveTitle: "Cave16"),
            .init(caveId: 6, caveTitle: "Cave17")
        ])
        
        availablePeriodList = [
            .init(periodMonthAsInteger: 0, periodTitle: "선택"),
            .init(periodMonthAsInteger: 1, periodTitle: "1개월"),
            .init(periodMonthAsInteger: 2, periodTitle: "2개월"),
            .init(periodMonthAsInteger: 3, periodTitle: "3개월"),
            .init(periodMonthAsInteger: 4, periodTitle: "4개월"),
            .init(periodMonthAsInteger: 5, periodTitle: "5개월"),
            .init(periodMonthAsInteger: 6, periodTitle: "6개월"),
            .init(periodMonthAsInteger: 7, periodTitle: "7개월"),
            .init(periodMonthAsInteger: 8, periodTitle: "8개월"),
            .init(periodMonthAsInteger: 9, periodTitle: "9개월"),
            .init(periodMonthAsInteger: 10, periodTitle: "10개월"),
            .init(periodMonthAsInteger: 11, periodTitle: "11개월"),
            .init(periodMonthAsInteger: 12, periodTitle: "12개월"),
        ]
    }
    
    func selectCaveToAdd(of cave: InsightCaveModel) {
        selectedCave.accept(cave)
    }
    
    func selectGoalPeriodToAdd(of period: InsightPeriodModel) {
        selectedPeriod.accept(period)
    }
    
    func resetSelectedCave() {
        selectedCave.accept(nil)
    }
}
