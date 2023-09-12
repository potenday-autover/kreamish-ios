//
//  FilterPopupContentTableViewController.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/06/26.
//

import Combine
import UIKit

import SnapKit

class FilterPopupContentTableViewController: UIViewController {
//    private var selectedFilterId = 1
//    private var subFilterList = ["신발", "아우터", "상의", "하의"]   // 현재 선택된 filter마다 달라짐
    var viewModel: FilterViewModel?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterPopupContentTableViewCell.self, forCellReuseIdentifier: FilterPopupContentTableViewCell.id)
        return tableView
    }()
    func setUp(viewModel: FilterViewModel) { // 아직 사용되지 않음
        self.viewModel = viewModel
    }
    func configureUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(FilterPopupTabViewController.filterPopupTabViewHeight)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension FilterPopupContentTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.currentSubFilterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterPopupContentTableViewCell.id, for: indexPath) as? FilterPopupContentTableViewCell, let viewModel = self.viewModel else {
            return UITableViewCell()
        }
        cell.setup(subFilter: viewModel.currentSubFilterList[indexPath.row])
        return cell
    }
}
extension FilterPopupContentTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }
}
