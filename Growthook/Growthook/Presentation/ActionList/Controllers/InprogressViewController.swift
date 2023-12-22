//
//  InprogressViewController.swift
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

protocol NotificationActionListVC: AnyObject {
    func moveToCompletePageByCancelButton()
    func moveToCompletePageBySaveButton()
}

final class InprogressViewController: BaseViewController, NotificationDismissBottomSheet {
    
    private var viewModel = ActionListViewModel()
    private var disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let scrapButton = ScrapOnlyButton()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Properties
    
    weak var delegate: NotificationActionListVC?
    private var isShowingScrappedData = false
    private var isPresentingBottomSheet = false
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func bindViewModel() {
        scrapButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.viewModel.inputs.didTapInprogressScrapButton()
                self.isShowingScrappedData.toggle()
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        view.backgroundColor = .gray700
        
        tableView.do {
            $0.showsVerticalScrollIndicator = false
            $0.separatorStyle = .none
            $0.register(ActionListTableViewCell.self, forCellReuseIdentifier: "actionListTableCell")
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .gray700
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        view.addSubviews(scrapButton, tableView)
        
        scrapButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().inset(18)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(scrapButton.snp.bottom).offset(13)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func presentToBottomSheet() {
        guard !isPresentingBottomSheet else {
            return
        }
        isPresentingBottomSheet = true

        let bottomSheetVC = ActionListBottomSheetViewController()
        bottomSheetVC.delegate = self

        self.present(bottomSheetVC, animated: true) {
            self.isPresentingBottomSheet = false
        }
    }
    
    private func getScrappedActionList() -> [ActionListModel] {
        return viewModel.outputs.actionList.value.filter { $0.scrapStatus == .scrap }
    }
    
    func notificationDismissInCancelButton() {
        print("notificationDismiss in InprogressVC by cancelButton")
        delegate?.moveToCompletePageByCancelButton()
    }
    
    func notificationDismissInSaveButton() {
        print("notificationDismiss in InprogressVC by saveButton")
        delegate?.moveToCompletePageBySaveButton()
    }
    
    // MARK: - @objc Methods
}


extension InprogressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowingScrappedData {
            return getScrappedActionList().count
        } else {
            return viewModel.outputs.actionList.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actionListTableCell", for: indexPath) as! ActionListTableViewCell
        let model: ActionListModel
        
        if isShowingScrappedData {
            model = getScrappedActionList()[indexPath.row]
        } else {
            model = viewModel.outputs.actionList.value[indexPath.row]
        }
        cell.configure(model)
        cell.disposeBag = DisposeBag()
        
        cell.seedButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.viewModel.inputs.didTapSeedButton()
            }
            .disposed(by: cell.disposeBag)

        cell.completButton.rx.tap
            .bind { [weak self]  in
                guard let self else { return }
                self.viewModel.inputs.didTapCompletButton()
                self.presentToBottomSheet()
            }
            .disposed(by: cell.disposeBag)

        return cell
    }
}
