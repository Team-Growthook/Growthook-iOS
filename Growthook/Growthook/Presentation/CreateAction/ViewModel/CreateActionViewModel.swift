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

enum FoldStatus {
    case folded
    case unfolded
    case none
}

protocol CreateActionViewModelInputs {
    func setActionPlan(with value: String)
    func setFolded(with value: FoldStatus)
}

protocol CreateActionViewModelOutputs {
    var name: BehaviorRelay<String> { get }
    var insight: BehaviorRelay<InsightModel> { get }
    var action: BehaviorRelay<String> { get }
    var folded: BehaviorRelay<FoldStatus> { get }
}

protocol CreateActionViewModelType {
    var inputs: CreateActionViewModelInputs { get }
    var outputs: CreateActionViewModelOutputs { get }
}

final class CreateActionViewModel: CreateActionViewModelInputs, CreateActionViewModelOutputs, CreateActionViewModelType {
    
    func setActionPlan(with value: String) {
        action.accept(value)
    }
    
    func setFolded(with value: FoldStatus) {
        folded.accept(value)
        switch folded.value {
        case .folded:
            folded.accept(.unfolded)
        case .unfolded:
            folded.accept(.folded)
        case .none:
            break
        }
        folded.accept(.none)
    }
    
    var inputs: CreateActionViewModelInputs { return self }
    var outputs: CreateActionViewModelOutputs { return self }
    
    var name = BehaviorRelay<String>(value: "")
    var insight = BehaviorRelay<InsightModel>(value: InsightModel(name: "", insight: "", date: "", dDay: "", memo: ""))
    var action = BehaviorRelay<String>(value: "")
    var folded = BehaviorRelay<FoldStatus>(value: .none)
    
    init() {
        insight.accept(InsightModel.dummy())
    }
}
