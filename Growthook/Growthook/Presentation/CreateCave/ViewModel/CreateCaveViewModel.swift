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
//sumResult: BehaviorRelay<CGFloat> { get }
    var name: BehaviorRelay<String> { get }
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
    
    var inputs: CreateCaveViewModelInputs { return self }
    var outputs: CreateCaveViewModelOutput { return self }
//    var sumResult: BehaviorRelay<CreateCaveModel> = BehaviorRelay(value: CreateCaveModel(name: "", description: ""))
    
    var caveModel: BehaviorRelay<CreateCaveModel> = BehaviorRelay(value: CreateCaveModel(name: "", description: ""))
    var switchStatus: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    let name = BehaviorRelay<String>(value: "")
    let description = BehaviorRelay<String>(value: "")
    init() {
        self.switchStatus.accept(false)
    }
    
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
    
    var isValid: Observable<Bool> {
        return BehaviorRelay.combineLatest(name, description)
            .map { name, description in
                print("name : \(name), description : \(description)")
                print(!name.isEmpty && !description.isEmpty)
                return !name.isEmpty && !description.isEmpty
            }
    }
}
