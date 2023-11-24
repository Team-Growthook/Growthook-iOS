//
//  CaveListHalfModal.swift
//  Growthook
//
//  Created by KJ on 11/23/23.
//

import UIKit

import Moya
import SnapKit
import Then
import RxCocoa
import RxSwift

class CaveListHalfModal: BaseViewController {
    
    // MARK: - UI Components
    
    private lazy var caveListTableView = UITableView(frame: .zero, style: .grouped)
    private let selectButton = UIButton()
    
    // MARK: - Properties
    
    private let viewModel = CaveListViewModel()
    private let disposeBag = DisposeBag()
    
    override func bindViewModel() {
        viewModel.outputs.caveList
            .bind(to: caveListTableView.rx
                .items(cellIdentifier: CaveListHalfModalCell.className, cellType: CaveListHalfModalCell.self)) {
                        (index, modal, cell) in
                    // 데이터바인딩
                }
                .disposed(by: disposeBag)
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
        self.view.backgroundColor = .gray400
        
        caveListTableView.do {
            $0.rowHeight = 54
            $0.separatorColor = .gray200
            $0.backgroundColor = .clear
            $0.separatorStyle = .singleLine
            $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        selectButton.do {
            $0.setTitle("선택", for: .normal)
            $0.backgroundColor = .green400
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.makeCornerRound(radius: 10)
        }
    }
    
    override func setLayout() {
        
        self.view.addSubviews(caveListTableView, selectButton)
        
        caveListTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
        
        selectButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
    }
    
    override func setDelegates() {
        caveListTableView.delegate = self
    }
    
    override func setRegister() {
        caveListTableView.register(CaveListHalfModalCell.self, forCellReuseIdentifier: CaveListHalfModalCell.className)
    }
}

extension CaveListHalfModal: UITableViewDelegate {}

