//
//  ActionListViewModel.swift
//  Growthook
//
//  Created by 천성우 on 11/16/23.
//

import RxCocoa
import RxSwift

protocol ActionListViewModelInput {
    func segmentButtonTap()
}

protocol ActionListViewModelOutput {
    var titleText: Driver<String> { get }
}

protocol ActionListViewModelType {
    var inputs: ActionListViewModelInput { get }
    var outputs: ActionListViewModelOutput { get }
}

final class ActionListViewModel: ActionListViewModelInput, ActionListViewModelOutput, ActionListViewModelType {
    var inputs: ActionListViewModelInput { return self }
    var outputs: ActionListViewModelOutput { return self }
    
    // MARK: - Outputs
    
    var titleText: Driver<String> {
        return .just("Action List")
    }
}





/**
 Input은
 1. 사용자의 이벤트 입력
 2. 뷰 컨트롤러 사이클에 의 한 입력
 
 액션리스트 화면에서 사용자의 입력은
 진행중/완료 탭 터치
 스크랩만 보기 버튼 터치
 씨앗 보기 버튼 터치
 
 */