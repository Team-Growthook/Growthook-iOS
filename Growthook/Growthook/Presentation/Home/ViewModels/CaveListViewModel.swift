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

}

protocol CaveListModelOutputs {
    var caveList: BehaviorRelay<[CaveProfile]> { get }
}

protocol CaveListModelType {
    var inputs: CaveListModelInputs { get }
    var outputs: CaveListModelOutputs { get }
}

final class CaveListViewModel: CaveListModelInputs, CaveListModelOutputs, CaveListModelType {
    
    var caveList: BehaviorRelay<[CaveProfile]> = BehaviorRelay(value: [])
    
    var inputs: CaveListModelInputs { return self }
    var outputs: CaveListModelOutputs { return self }
    
    init() {
        self.caveList.accept(CaveProfile.caveprofileDummyData())
    }
}

