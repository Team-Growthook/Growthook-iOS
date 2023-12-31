//
//  CreateCaveViewModel.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/12/23.
//

import UIKit

import RxCocoa
import RxSwift
import RxRelay

protocol CreateCaveViewModelInputs {
    func setName(with value: String)
    func setDescription(with value: String)
    func switchTapped()
    func createButtonTapped()
}

protocol CreateCaveViewModelOutput {
    var name: BehaviorRelay<String> { get }
    var description: BehaviorRelay<String> { get }
    var caveModel: BehaviorRelay<CreateCaveModel> { get }
    var switchStatus: BehaviorRelay<Bool> { get }
    var isValid: Observable<Bool> { get }
}

protocol CreateCaveViewModelType {
    var inputs: CreateCaveViewModelInputs { get }
    var outputs: CreateCaveViewModelOutput { get }
}

final class CreateCaveViewModel: CreateCaveViewModelInputs, CreateCaveViewModelOutput, CreateCaveViewModelType {
    
    func setName(with value: String) {
        name.accept(value)
    }
    
    func setDescription(with value: String) {
        description.accept(value)
    }
    
    func switchTapped() {
        print("switchTapped")
    }
    
    func createButtonTapped() {
        print(CreateCaveModel(name: name.value, description: description.value))
        caveModel.accept(CreateCaveModel(name: name.value, description: description.value))
    }
    
    var inputs: CreateCaveViewModelInputs { return self }
    var outputs: CreateCaveViewModelOutput { return self }
    
    var name = BehaviorRelay<String>(value: "")
    var description = BehaviorRelay<String>(value: "")
    var caveModel: BehaviorRelay<CreateCaveModel> = BehaviorRelay(value: CreateCaveModel(name: "", description: ""))
    var switchStatus: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var isValid: Observable<Bool> {
        return BehaviorRelay.combineLatest(name, description)
            .map { name, description in
                return !name.isEmpty && description != "동굴을 간략히 소개해주세요"
            }
    }
    
    init() {
        self.switchStatus.accept(false)
    }
}
