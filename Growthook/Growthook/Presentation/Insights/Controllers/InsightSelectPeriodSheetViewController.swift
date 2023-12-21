//
//  InsightSelectPeriodSheetViewController.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/21/23.
//

import UIKit

import RxCocoa
import RxSwift

final class InsightSelectPeriodSheetViewController: BaseViewController {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var viewModel: InsightsViewModel
    private var selectedPeriodMonthCache: InsightPeriodModel?
    
    // MARK: - UI Properties
    private let periodPikcerView = UIPickerView()
    private let selectPeriodButton = UIButton()
    
    // MARK: - Life Cycles
    init(viewModel: InsightsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func bindViewModel() {
    // MARK: - Tap Actions
        selectPeriodButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                if selectedPeriodMonthCache != nil {
                    guard let selectedPeriodMonthCache else { return }
                    self.viewModel.inputs.selectGoalPeriodToAdd(of: selectedPeriodMonthCache)
                }
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }

    // MARK: - Styles
    override func setStyles() {
        view.backgroundColor = .gray400

        selectPeriodButton.do {
            $0.layer.cornerRadius = 10
            $0.setTitle("선택", for: .normal)
            $0.backgroundColor = .green400
            $0.setTitleColor(.white000, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
        }
        
        periodPikcerView.do {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    // MARK: - Layout
    override func setLayout() {
        view.addSubviews(periodPikcerView, selectPeriodButton)
        
        periodPikcerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(240)
        }
        
        selectPeriodButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - UIPicker Settings
extension InsightSelectPeriodSheetViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.outputs.availablePeriodList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.outputs.availablePeriodList[row].periodTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedPeriodMonthCache = viewModel.outputs.availablePeriodList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width-20, height: 45))
        let itemLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width-20, height: 45))
        itemLabel.text = viewModel.outputs.availablePeriodList[row].periodTitle
        itemLabel.textAlignment = .center
        itemLabel.font = .fontGuide(.body1_reg)
        
        newView.addSubview(itemLabel)
        return newView
    }
}
