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
}

protocol HomeViewModelOutputs {
    
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType {
    
    private let items = BehaviorSubject<[CaveProfileModel]>(value: [])
    var data: Observable<[CaveProfileModel]> {
        return items.asObserver()
    }
    
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
    
    init() {}
    
    func caveCollectionViewBind() {
        let dummy = CaveProfileModel.caveprofileDummyData()
        items.onNext(dummy)
    }
}
