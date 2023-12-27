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
    func addActionPlan(with value: String)
    func setCount(count: Int)
}

protocol CreateActionViewModelOutputs {
    var name: BehaviorRelay<String> { get }
    var insight: BehaviorRelay<InsightModel> { get }
    var action: BehaviorRelay<[String]> { get }
    var countPlan: BehaviorRelay<Int> { get }
}

protocol CreateActionViewModelType {
    var inputs: CreateActionViewModelInputs { get }
    var outputs: CreateActionViewModelOutputs { get }
}

final class CreateActionViewModel: CreateActionViewModelInputs, CreateActionViewModelOutputs, CreateActionViewModelType {
    
    var specificPlan: [String] = []
    func addActionPlan(with value: String) {
        specificPlan.append(value)
        action.accept(specificPlan)
    }
    
    func setCount(count: Int) {
        countPlan.accept(count)
    }

    var inputs: CreateActionViewModelInputs { return self }
    var outputs: CreateActionViewModelOutputs { return self }
    
    var name = BehaviorRelay<String>(value: "")
    var insight = BehaviorRelay<InsightModel>(value: InsightModel(name: "", insight: "", date: "", dDay: "", memo: ""))
    var action = BehaviorRelay<[String]>(value: [])
    var countPlan = BehaviorRelay<Int>(value: 1)
    
    init() {
        insight.accept(InsightModel.dummy())
    }
    
    private func setCountPlan() {
        
    }
}
