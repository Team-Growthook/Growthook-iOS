//
//  CreateCaveViewModel.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/12/23.
//

import UIKit

import RxCocoa
import RxSwift

protocol CreateCaveViewModelInputs {
    func switchTapped()
    func createButtonTapped(with value: CreateCaveModel)
}

protocol CreateCaveViewModelOutput {
    var switchStatus: BehaviorRelay<Bool> { get }
}

protocol CreateCaveViewModelType {
    var inputs: CreateCaveViewModelInputs { get }
    var outputs: CreateCaveViewModelOutput { get }
}

final class CreateCaveViewModel: CreateCaveViewModelInputs, CreateCaveViewModelOutput, CreateCaveViewModelType {
    
    var inputs: CreateCaveViewModelInputs { return self }
    var outputs: CreateCaveViewModelOutput { return self }
    var switchStatus: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    init() {
        self.switchStatus.accept(false)
    }
    
    func switchTapped() {
        print("switchTapped")
    }
    
    func createButtonTapped(with value: CreateCaveModel) {
        print(value)
    }
}
