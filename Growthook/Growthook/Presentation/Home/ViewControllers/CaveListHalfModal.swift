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
    var indexPath: IndexPath? = nil
    private let deSelectInsightNotification = Notification.Name("DeSelectInsightNotification")
    
    override func bindViewModel() {
        viewModel.outputs.caveList
            .bind(to: caveListTableView.rx
                .items(cellIdentifier: CaveListHalfModalCell.className, cellType: CaveListHalfModalCell.self)) {
                        (index, model, cell) in
                    cell.configureCell(model)
                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
                    if let selectedIndexPath = self.viewModel.outputs.selectedCellIndex.value {
                        cell.isSelected = selectedIndexPath.row == index
                    } else {
                        cell.isSelected = false
                    }
                }
                .disposed(by: disposeBag)
        viewModel.outputs.selectedCellIndex
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                if let indexPath = indexPath {
                    self.updateSelectedCell(at: indexPath)
                }
            })
            .disposed(by: disposeBag)
        selectButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.inputs.selectButtonTap()
            }
            .disposed(by: disposeBag)
        viewModel.outputs.moveToCave
            .subscribe(onNext: { [weak self] in
                self?.clearInsight()
                self?.dismissToHomeVC()
            })
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
    
    // MARK: - Layout Helper
    
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
    
    // MARK: - Methods
    
    override func setDelegates() {
        caveListTableView.delegate = self
    }
    
    override func setRegister() {
        caveListTableView.register(CaveListHalfModalCell.self, forCellReuseIdentifier: CaveListHalfModalCell.className)
    }
    
    private func updateSelectedCell(at indexPath: IndexPath?) {
        caveListTableView.reloadData()
        if let indexPath = self.viewModel.outputs.selectedCellIndex.value {
            caveListTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    private func dismissToHomeVC() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func clearInsight() {
        NotificationCenter.default.post(name: deSelectInsightNotification, object: nil)
    }
}

extension CaveListHalfModal: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.caveListCellTap(at: indexPath)
    }
}

