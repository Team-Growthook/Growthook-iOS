//
//  CaveDetailViewModel.swift
//  Growthook
//
//  Created by KJ on 12/16/23.
//

import UIKit

import RxSwift
import RxCocoa

protocol CaveDetailViewModelInputs {

}

protocol CaveDetailViewModelOutputs {

}

protocol CaveDetailViewModelType {
    var inputs: CaveDetailViewModelInputs { get }
    var outputs: CaveDetailViewModelOutputs { get }
}

final class CaveDetailViewModel: CaveDetailViewModelInputs, CaveDetailViewModelOutputs, CaveDetailViewModelType {
    
    
    var inputs: CaveDetailViewModelInputs { return self }
    var outputs: CaveDetailViewModelOutputs { return self }
    
    init() {}
}
