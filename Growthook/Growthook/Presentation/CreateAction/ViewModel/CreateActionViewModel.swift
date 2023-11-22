//
//  CreateActionViewModel.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/22/23.
//

import UIKit

import RxCocoa
import RxSwift
import RxRelay

protocol CreateActionViewModelInputs {
    func setActionPlan(with value: String)
}

protocol CreateActionViewModelOutputs {
    var name: BehaviorRelay<String> { get }
    var insight: BehaviorRelay<InsightModel> { get }
    var action: BehaviorRelay<String> { get }
}

protocol CreateActionViewModelType {
    var inputs: CreateActionViewModelInputs { get }
    var outputs: CreateActionViewModelOutputs { get }
}

final class CreateActionViewModel: CreateActionViewModelInputs, CreateActionViewModelOutputs, CreateActionViewModelType {
    
    func setActionPlan(with value: String) {
        action.accept(value)
    }

    var inputs: CreateActionViewModelInputs { return self }
    var outputs: CreateActionViewModelOutputs { return self }
    
    var name = BehaviorRelay<String>(value: "")
    var insight = BehaviorRelay<InsightModel>(value: InsightModel(name: "", insight: "", date: "", dDay: "", memo: ""))
    var action = BehaviorRelay<String>(value: "")
    
    init() {
        insight.accept(InsightModel.dummy())
    }
}
