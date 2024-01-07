//
//  OnboardingViewModel.swift
//  Growthook
//
//  Created by 천성우 on 12/29/23.
//

import RxCocoa
import RxSwift

protocol OnboardingModelInput {

}

protocol OnboardingModelOutput {

}

protocol OnboardingViewModelType {
    var inputs: OnboardingModelInput { get }
    var outputs: OnboardingModelOutput { get }
}

final class OnboardingViewModel: OnboardingModelInput, OnboardingModelOutput, OnboardingViewModelType {
 

    var inputs: OnboardingModelInput { return self }
    var outputs: OnboardingModelOutput { return self }
    
    init() {

    }
    
 
}
