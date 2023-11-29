//
//  HomeViewModel.swift
//  Growthook
//
//  Created by KJ on 11/10/23.
//

import UIKit

import RxSwift
import RxCocoa

protocol HomeViewModelInputs {
    func handleLongPress(at indexPath: IndexPath)
    func dismissInsightTap(at indexPath: IndexPath)
    func reloadInsight()
    func insightCellTap(at indexPath: IndexPath)
    func giveUpButtonTap()
}

protocol HomeViewModelOutputs {
    var caveProfile: BehaviorRelay<[CaveProfile]> { get }
    var insightList: BehaviorRelay<[InsightList]> { get }
    var insightLongTap: PublishSubject<IndexPath> { get }
    var insightBackground: PublishSubject<IndexPath> { get }
    var pushToInsightDetail: PublishSubject<IndexPath> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType {
    
    var caveProfile: BehaviorRelay<[CaveProfile]> = BehaviorRelay(value: [])
    var insightList: BehaviorRelay<[InsightList]> = BehaviorRelay(value: [])
    var insightLongTap: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    var insightBackground: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    let reloadInsightSubject: PublishSubject<Void> = PublishSubject<Void>()
    var pushToInsightDetail: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    var dismissToHomeVC: PublishSubject<Void> = PublishSubject<Void>()
    
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
    
    init() {
        self.caveProfile.accept(CaveProfile.caveprofileDummyData())
        self.insightList.accept(InsightList.insightListDummyData())
    }
    
    func handleLongPress(at indexPath: IndexPath) {
        let items = InsightList.insightListDummyData()
        let selectedItem = items[indexPath.item]
        print("\(indexPath.row) / 제목 :  \(selectedItem.title)")
        self.insightLongTap.onNext(indexPath)
    }
    
    func dismissInsightTap(at indexPath: IndexPath) {
        self.insightBackground.onNext(indexPath)
    }
    
    func reloadInsight() {
        self.reloadInsightSubject.onNext(())
    }
    
    func insightCellTap(at indexPath: IndexPath) {
        self.pushToInsightDetail.onNext(indexPath)
    }
    
    func giveUpButtonTap() {
        self.dismissToHomeVC.onNext(())
    }
}
