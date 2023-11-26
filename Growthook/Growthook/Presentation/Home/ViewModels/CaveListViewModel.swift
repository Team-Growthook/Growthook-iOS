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
    var selectedCellIndex: BehaviorRelay<IndexPath?> { get }
    var unSelectedCellIndex: BehaviorRelay<IndexPath?> { get }
}

protocol CaveListModelType {
    var inputs: CaveListModelInputs { get }
    var outputs: CaveListModelOutputs { get }
}

final class CaveListViewModel: CaveListModelInputs, CaveListModelOutputs, CaveListModelType {
    
    var caveList: BehaviorRelay<[CaveProfile]> = BehaviorRelay(value: [])
    var selectedCellIndex: BehaviorRelay<IndexPath?> = BehaviorRelay<IndexPath?>(value: nil)
    var unSelectedCellIndex: BehaviorRelay<IndexPath?> = BehaviorRelay<IndexPath?>(value: nil)
    
    var inputs: CaveListModelInputs { return self }
    var outputs: CaveListModelOutputs { return self }
    
    init() {
        self.caveList.accept(CaveProfile.caveprofileDummyData())
    }
    
    func caveListCellTap(at indexPath: IndexPath) {
//        self.selectedCellIndex.onNext(indexPath)
//        guard selectedCellIndex.value != indexPath else { return }
//        if let selectedIndexPath = selectedCellIndex.value {
            // 선택된 셀이 있을 때
//            unSelectedCellIndex.accept(indexPath)
//            selectedCellIndex.accept(nil)
//        }
        selectedCellIndex.accept(indexPath)
    }
}

