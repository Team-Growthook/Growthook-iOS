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
    
    override func loadView() {
        self.view = createActionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    deinit {
        print(#function)
    }
    
//    override func bindViewModel() {
//        <#code#>
//    }
}
