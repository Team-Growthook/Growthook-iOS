//
//  CaveListViewModel.swift
//  Growthook
//
//  Created by KJ on 11/24/23.
//

import Foundation

import UIKit

import RxSwift
import RxCocoa

protocol CaveListModelInputs {
    func caveListCellTap(at indexPath: IndexPath)
    func selectButtonTap()
}

protocol CaveListModelOutputs {
    var caveList: BehaviorRelay<[CaveProfile]> { get }
    var selectedCellIndex: BehaviorRelay<IndexPath?> { get }
    var dismissToHome: Observable<Void> { get }
}

protocol CaveListModelType {
    var inputs: CaveListModelInputs { get }
    var outputs: CaveListModelOutputs { get }
}

final class CaveListViewModel: CaveListModelInputs, CaveListModelOutputs, CaveListModelType {
    
    var caveList: BehaviorRelay<[CaveProfile]> = BehaviorRelay(value: [])
    var selectedCellIndex: BehaviorRelay<IndexPath?> = BehaviorRelay<IndexPath?>(value: nil)
    let buttonTapSubject: PublishSubject<Void> = PublishSubject<Void>()
    var dismissToHome: Observable<Void> {
        return buttonTapSubject.asObservable()
    }
    
    var inputs: CaveListModelInputs { return self }
    var outputs: CaveListModelOutputs { return self }
    
    init() {
        self.caveList.accept(CaveProfile.caveprofileDummyData())
    }
    
    func caveListCellTap(at indexPath: IndexPath) {
        selectedCellIndex.accept(indexPath)
    }
    
    func selectButtonTap() {
        return buttonTapSubject.onNext(())
    }
}

