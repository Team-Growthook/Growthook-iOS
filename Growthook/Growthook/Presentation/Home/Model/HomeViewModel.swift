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
    func caveCollectionViewBind()
    func insightListCollectionViewBind()
}

protocol HomeViewModelOutputs {
    
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType {
    
    private let caveProfileItems = BehaviorSubject<[CaveProfileModel]>(value: [])
    var caveProfileData: Observable<[CaveProfileModel]> {
        return caveProfileItems.asObserver()
    }
    private let insightListItems = BehaviorSubject<[InsightListModel]>(value: [])
    var insightListData: Observable<[InsightListModel]> {
        return insightListItems.asObserver()
    }
    
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
    
    init() {}
    
    func caveCollectionViewBind() {
        let dummy = CaveProfileModel.caveprofileDummyData()
        caveProfileItems.onNext(dummy)
    }
    
    func insightListCollectionViewBind() {
        let dummy = InsightListModel.insightListDummyData()
        insightListItems.onNext(dummy)
    }
}
