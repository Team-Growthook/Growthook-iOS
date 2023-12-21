//
//  InsightSelectCaveSheetViewController.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/21/23.
//

import UIKit

import RxCocoa
import RxSwift

final class InsightSelectCaveSheetViewController: BaseViewController {

    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var viewModel: InsightsViewModel
    private var selectedCaveCache: InsightCaveModel?
    
    // MARK: - UI Properties
    private let caveTableView = UITableView()
    private let selectCaveButton = UIButton()
    
    // MARK: - Life Cycles
    init(viewModel: InsightsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetSelectedCaveWhenInitialized()
    }
    
    override func bindViewModel() {
    // MARK: - Tap Actions
        caveTableView.rx.modelSelected(InsightCaveModel.self)
            .bind { [weak self] data in
                guard let self else { return }
                self.selectedCaveCache = .init(caveId: data.caveId, caveTitle: data.caveTitle)
            }
            .disposed(by: disposeBag)
        
        selectCaveButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                if selectedCaveCache != nil {
                    guard let selectedCaveCache else { return }
                    self.viewModel.inputs.selectCaveToAdd(of: selectedCaveCache)
                }
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
    // MARK: - Bind UI With Data
        viewModel.outputs.myOwnCaves
            .bind(to: caveTableView.rx.items(cellIdentifier: InsightSelectCaveTableViewCell.className, cellType: InsightSelectCaveTableViewCell.self)) { row, data, cell in
                let caveModelData = InsightCaveModel(caveId: data.caveId, caveTitle: data.caveTitle)
                cell.configure(with: caveModelData)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Register Cell
    override func setRegister() {
        caveTableView.register(InsightSelectCaveTableViewCell.self, forCellReuseIdentifier: InsightSelectCaveTableViewCell.className)
    }
    
    // MARK: - Styles
    override func setStyles() {
        view.backgroundColor = .gray400
        
        caveTableView.do {
            $0.rowHeight = 54
            $0.separatorColor = .gray200
            $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.backgroundColor = .gray400
            $0.allowsMultipleSelection = false
        }
        
        selectCaveButton.do {
            $0.layer.cornerRadius = 10
            $0.setTitle("선택", for: .normal)
            $0.backgroundColor = .green400
            $0.setTitleColor(.white000, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
        }
    }
    
    // MARK: - Layout
    override func setLayout() {
        view.addSubviews(caveTableView, selectCaveButton)
        
        caveTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(250)
        }
        
        selectCaveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InsightSelectCaveSheetViewController {
    
    // MARK: - Methods for Resetting Data
    private func resetSelectedCaveWhenInitialized() {
        viewModel.inputs.resetSelectedCave()
    }
}
