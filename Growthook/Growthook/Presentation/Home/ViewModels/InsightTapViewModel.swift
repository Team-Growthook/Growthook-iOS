//
//  InsightTapViewModel.swift
//  Growthook
//
//  Created by KJ on 11/24/23.
//

import UIKit

import RxSwift
import RxCocoa

protocol InsightTapModelInputs {
    func moveButtonTap()
    func deleteButtonTap()
}

protocol InsightTapModelOutputs {
    var presentToCaveList: PublishSubject<Void> { get }
    var removeInsightAlertView: PublishSubject<Void> { get }
}

protocol InsightTapModelType {
    var inputs: InsightTapModelInputs { get }
    var outputs: InsightTapModelOutputs { get }
}

final class InsightTapViewModel: InsightTapModelInputs, InsightTapModelOutputs, InsightTapModelType {
    
    var presentToCaveList: PublishSubject<Void> = PublishSubject<Void>()
    var removeInsightAlertView: PublishSubject<Void> = PublishSubject<Void>()
    
    func moveButtonTap() {
        presentToCaveList.onNext(())
    }
    
    func deleteButtonTap() {
        removeInsightAlertView.onNext(())
    }
    
    var inputs: InsightTapModelInputs { return self }
    var outputs: InsightTapModelOutputs { return self }
    
    init() {}
}
