//
//  CompleteViewController.swift
//  Growthook
//
//  Created by 천성우 on 11/18/23.
//

import UIKit

import Moya
import RxCocoa
import RxSwift
import SnapKit
import Then

final class CompleteViewController: BaseViewController {
    
    private var viewModel = ActionListViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {

    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        view.backgroundColor = .green400
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {

    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
