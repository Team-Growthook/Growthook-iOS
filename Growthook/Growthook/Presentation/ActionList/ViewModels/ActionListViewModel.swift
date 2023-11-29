//
//  ActionListViewModel.swift
//  Growthook
//
//  Created by 천성우 on 11/16/23.
//

import RxCocoa
import RxSwift

protocol ActionListViewModelInput {
    func didTapInProgressButton()
    func didTapCompletedButton()
    func didTapInprogressScrapButton()
    func didTapSeedButton()
    func didTapCompletButton()
    func didTapReviewButton()
    func setReviewText(with value: String)
}

protocol ActionListViewModelOutput {
    var titleText: Driver<String> { get }
    var titlePersent: Driver<String> { get }
    var selectedIndex: BehaviorRelay<Int> { get }
    var actionList: BehaviorRelay<[ActionListModel]> { get }
    var completeActionList: BehaviorRelay<[CompleteActionListModel]> { get }
    var isReviewEntered: Driver<Bool> { get }
    var reviewTextCount: Driver<String> { get }
}

protocol ActionListViewModelType {
    var inputs: ActionListViewModelInput { get }
    var outputs: ActionListViewModelOutput { get }
}

final class ActionListViewModel: ActionListViewModelInput, ActionListViewModelOutput, ActionListViewModelType {
    
    var selectedIndex: BehaviorRelay<Int> = BehaviorRelay(value: 1)
    var actionList: BehaviorRelay<[ActionListModel]> = BehaviorRelay(value: [])
    var completeActionList: BehaviorRelay<[CompleteActionListModel]> = BehaviorRelay(value: [])
    var reviewText = BehaviorRelay<String>(value: "")
    
    var inputs: ActionListViewModelInput { return self }
    var outputs: ActionListViewModelOutput { return self }
    
    
    var titleText: Driver<String> {
        return .just("Action List")
    }
    
    var titlePersent: Driver<String> {
        return .just("00")
    }
    
    var isReviewEntered: Driver<Bool> {
         return reviewText.asDriver()
             .map { !$0.isEmpty }
     }
    
    var reviewTextCount: Driver<String> {
        return reviewText.asDriver()
            .map { "\($0.count)/300" }
    }
    
    func didTapInProgressButton() {
        selectedIndex.accept(1)
    }

    func didTapCompletedButton() {
        selectedIndex.accept(0)
    }
    
    func didTapInprogressScrapButton() {
        print("스크랩만 보기 버튼이 탭 되었습니다")
    }
    
    func didTapSeedButton() {
        print("씨앗보기 버튼이 탭 되었습니다")
    }
    
    func didTapCompletButton() {
        print("완료하기 버튼이 탭 되었습니다")
    }
    
    func didTapReviewButton() {
        print("리뷰보기 버튼이 탭 되었습니다")
    }
    
    func setReviewText(with value: String) {
        reviewText.accept(value)
    }
    
    init() {
        self.actionList.accept(ActionListModel.actionListModelDummyData())
        self.completeActionList.accept(CompleteActionListModel.completeActionListModelDummyData())
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
