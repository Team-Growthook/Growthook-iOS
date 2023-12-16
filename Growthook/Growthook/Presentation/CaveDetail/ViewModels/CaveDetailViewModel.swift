//
//  CaveDetailViewModel.swift
//  Growthook
//
//  Created by KJ on 12/16/23.
//

import UIKit

import RxSwift
import RxCocoa

protocol CaveDetailViewModelInputs {
    
}

protocol CaveDetailViewModelOutputs {
    var insightList: BehaviorRelay<[InsightList]> { get }
}

protocol CaveDetailViewModelType {
    var inputs: CaveDetailViewModelInputs { get }
    var outputs: CaveDetailViewModelOutputs { get }
}

final class CaveDetailViewModel: CaveDetailViewModelInputs, CaveDetailViewModelOutputs, CaveDetailViewModelType {
    
    var insightList: BehaviorRelay<[InsightList]> = BehaviorRelay(value: [])
    
    var inputs: CaveDetailViewModelInputs { return self }
    var outputs: CaveDetailViewModelOutputs { return self }
    
    init() {
        self.insightList.accept(InsightList.insightListDummyData())
    }
}
