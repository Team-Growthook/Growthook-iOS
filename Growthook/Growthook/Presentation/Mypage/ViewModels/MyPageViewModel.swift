//
//  MyPageViewModel.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/15/23.
//

import UIKit

import RxCocoa
import RxSwift

protocol MyPageViewModelInputs {
    func editMyInformationDidTap()
    func growthookManualDidTap()
    func announcementDidTap()
    func frequentQuestionsDidTap()
    func termsAndPoliciesDidTap()
    func logOutDidTap()
}

protocol MyPageViewModelOutputs {
    var userProfileImage: BehaviorRelay<String> { get }
    var userProfileName: BehaviorRelay<String> { get }
    var userEarnedThookCount: BehaviorRelay<Int> { get }
    var userSpentThookCount: BehaviorRelay<Int> { get }
    var myPageComponentsList: BehaviorRelay<[String]> { get }
    var versionNumber: BehaviorRelay<String> { get }
}

protocol MyPageViewModelType {
    var inputs: MyPageViewModelInputs { get }
    var outputs: MyPageViewModelOutputs { get }
}

final class MyPageViewModel: MyPageViewModelInputs, MyPageViewModelOutputs, MyPageViewModelType {
    
    private let myPageList: [String] = [
        "growthook 사용법", "공지사항", "자주 묻는 질문",
        "약관 및 정책", "버전 정보", "로그아웃"
    ]
    var userProfileImage: BehaviorRelay<String> = BehaviorRelay(value: "")
    var userProfileName: BehaviorRelay<String> = BehaviorRelay(value: "")
    var userEarnedThookCount: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var userSpentThookCount: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var myPageComponentsList: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    var versionNumber = BehaviorRelay(value: "0.0.0")
    
    var inputs: MyPageViewModelInputs { return self }
    var outputs: MyPageViewModelOutputs { return self }
    
    init() {
        myPageComponentsList.accept(myPageList)
        setVersionOfTheApp()
//        setDummyData()
    }
    
    func editMyInformationDidTap() {
        print("EditMyInformation Tapped")
    }
    
    func growthookManualDidTap() {
        print("Growthook Manual Tapped")
    }
    
    func announcementDidTap() {
        if let url = URL(string: "SOME URL") {
            UIApplication.shared.open(url)
        }
    }
    
    func frequentQuestionsDidTap() {
        if let url = URL(string: "SOME URL") {
            UIApplication.shared.open(url)
        }
    }
    
    func termsAndPoliciesDidTap() {
        if let url = URL(string: "SOME URL") {
            UIApplication.shared.open(url)
        }
    }
    
    func logOutDidTap() {
        print("LogOut Tapped")
    }
}

extension MyPageViewModel {
    
//    private func setDummyData() {
//        userProfileName.accept("GrowthookMan")
//        userEarnedThookCount.accept(60)
//        userSpentThookCount.accept(32)
//        userProfileImage.accept("https://scontent-gmp1-1.xx.fbcdn.net/v/t39.30808-6/302492881_1018016299029456_116960852711349429_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=m8FQanKBjigAX9xHgcr&_nc_ht=scontent-gmp1-1.xx&oh=00_AfA97sLh96dO9yRUJmOtBLqnkmV53olEj2OWDNR9DqhhPA&oe=658226F5")
//    }
    
    private func setVersionOfTheApp() {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return
        }
        versionNumber.accept(version)
    }
}
