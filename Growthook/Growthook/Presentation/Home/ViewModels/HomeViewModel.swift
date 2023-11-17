//
//  HomeViewModel.swift
//  Growthook
//
//  Created by KJ on 11/10/23.
//

import UIKit

import RxSwift
import RxCocoa

protocol HomeViewModelInputs {
    
}

protocol HomeViewModelOutputs {
    var caveCollectionViewBind: BehaviorRelay<[CaveProfileModel]> { get }
    var insightListCollectionViewBind: BehaviorRelay<[InsightListModel]> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType {
    var caveCollectionViewBind: BehaviorRelay<[CaveProfileModel]> = BehaviorRelay(value: [])
    var insightListCollectionViewBind: BehaviorRelay<[InsightListModel]> = BehaviorRelay(value: [])
    
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
    
    init() {
        self.caveCollectionViewBind.accept(CaveProfileModel.caveprofileDummyData())
        self.insightListCollectionViewBind.accept(InsightListModel.insightListDummyData())
    }
}
