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
    func handleLongPress(at indexPath: IndexPath)
    
}

protocol HomeViewModelOutputs {
    var caveProfile: BehaviorRelay<[CaveProfile]> { get }
    var insightList: BehaviorRelay<[InsightList]> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType {
    
    var caveProfile: BehaviorRelay<[CaveProfile]> = BehaviorRelay(value: [])
    var insightList: BehaviorRelay<[InsightList]> = BehaviorRelay(value: [])
    
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
    
    init() {
        self.caveProfile.accept(CaveProfile.caveprofileDummyData())
        self.insightList.accept(InsightList.insightListDummyData())
    }
    
    func handleLongPress(at indexPath: IndexPath) {
        let items = InsightList.insightListDummyData()
        let selectedItem = items[indexPath.item]
        print("\(indexPath.row) / 제목 :  \(selectedItem.title)")
    }
}
