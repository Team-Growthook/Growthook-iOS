//
//  CreateActionViewControlller.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/22/23.
//


import UIKit

import RxCocoa
import RxSwift
import Then

final class CreateActionViewControlller: BaseViewController {
    
    private let createActionView = CreateActionView()
    private var viewModel = CreateActionViewModel()
    private let disposeBag = DisposeBag()
    
    private var isFolded = true
    
    override func loadView() {
        self.view = createActionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    deinit {
        print(#function)
    }
    
    override func bindViewModel() {
        viewModel.outputs.insight
            .bind(onNext: { value in
                self.createActionView.insightView.bindInsight(model: value)
            })
            .disposed(by: disposeBag)
        
        createActionView.insightView.moreButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                switch isFolded {
                case true:
                    self.createActionView.setShowingAnimation()
                case false:
                    self.createActionView.setFoldingAnimation()
                }
                self.isFolded.toggle()
            }
            .disposed(by: disposeBag)
    }
}
