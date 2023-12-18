//
//  RemoveInsightViewModel.swift
//  Growthook
//
//  Created by KJ on 11/29/23.
//

import UIKit

import RxSwift
import RxCocoa

protocol RemoveInsightViewModelInputs {
    func keepButtonTap()
    func removeButtonTap(at indexPath: IndexPath)
}

protocol RemoveInsightViewModelOutputs {
    var dismissToHome: PublishSubject<Void> { get }
    var removeButtonTap: PublishSubject<IndexPath> { get }
}

protocol RemoveInsightViewModelType {

}

final class RemoveInsightViewModel: RemoveInsightViewModelInputs, RemoveInsightViewModelOutputs, RemoveInsightViewModelType {
    
    var dismissToHome: PublishSubject<Void> = PublishSubject<Void>()
    var removeButtonTap: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    
    var inputs: RemoveInsightViewModelInputs { return self }
    var outputs: RemoveInsightViewModelOutputs { return self }
    
    init() {}
    
    func keepButtonTap() {
        self.dismissToHome.onNext(())
    }
    
    func removeButtonTap(at indexPath: IndexPath) {
        // 인사이트 삭제
    }
}
