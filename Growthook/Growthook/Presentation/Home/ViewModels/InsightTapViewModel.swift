//
//  InsightTapViewModel.swift
//  Growthook
//
//  Created by KJ on 11/24/23.
//

import Foundation

import UIKit

import RxSwift
import RxCocoa

protocol InsightTapModelInputs {
    func moveButtonTap()
//    func deleteButtonTap()
}

protocol InsightTapModelOutputs {
    var presentToCaveList: Observable<Void> { get }
}

protocol InsightTapModelType {
    var inputs: InsightTapModelInputs { get }
    var outputs: InsightTapModelOutputs { get }
}

final class InsightTapViewModel: InsightTapModelInputs, InsightTapModelOutputs, InsightTapModelType {
    
    let buttonTapSubject: PublishSubject<Void> = PublishSubject<Void>()
    var presentToCaveList: Observable<Void> {
        return buttonTapSubject.asObservable()
    }
    
    func moveButtonTap() {
        return buttonTapSubject.onNext(())
    }
    
    var inputs: InsightTapModelInputs { return self }
    var outputs: InsightTapModelOutputs { return self }
    
    
    init() {}
}
