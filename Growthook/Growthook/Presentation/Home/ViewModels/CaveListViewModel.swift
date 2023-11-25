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
}

protocol CaveListModelOutputs {
    var caveList: BehaviorRelay<[CaveProfile]> { get }
    var selectedCellIndex: BehaviorSubject<IndexPath?> { get }
    var unSelectedCellIndex: PublishSubject<IndexPath> { get }
}

protocol CaveListModelType {
    var inputs: CaveListModelInputs { get }
    var outputs: CaveListModelOutputs { get }
}

final class CaveListViewModel: CaveListModelInputs, CaveListModelOutputs, CaveListModelType {
    
    var caveList: BehaviorRelay<[CaveProfile]> = BehaviorRelay(value: [])
    var selectedCellIndex: BehaviorSubject<IndexPath?> = BehaviorSubject<IndexPath?>(value: nil)
    var unSelectedCellIndex: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    
    var inputs: CaveListModelInputs { return self }
    var outputs: CaveListModelOutputs { return self }
    
    init() {
        self.caveList.accept(CaveProfile.caveprofileDummyData())
    }
    
    func caveListCellTap(at indexPath: IndexPath) {
        self.selectedCellIndex.onNext(indexPath)
    }
}

