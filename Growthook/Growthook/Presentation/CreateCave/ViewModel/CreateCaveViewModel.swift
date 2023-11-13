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
    func createButtonTapped(with value: CreateCaveModel)
}

protocol CreateCaveViewModelType {
    var inputs: CreateCaveViewModelInputs { get }
}

final class CreateCaveViewModel: CreateCaveViewModelInputs, CreateCaveViewModelType {
    
    var inputs: CreateCaveViewModelInputs { return self }
    
    init() {}
    
    func createButtonTapped(with value: CreateCaveModel) {
        print(value)
    }
}
