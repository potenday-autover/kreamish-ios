
import UIKit

import SnapKit

enum KindOfCell {
    case banner(viewModel: HomeViewModel)
    case recommendCategory(viewModel: HomeViewModel)
    case dropped(viewModel: HomeViewModel)
}

final class HomeViewController: UIViewController {
    private var viewModel: HomeViewModel?
    private var cellList: [UITableViewCell] = []
    private var cells: [KindOfCell] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(
            HomeBannerTableViewCell.self,
            forCellReuseIdentifier: "HomeBannerTableViewCell"
        )
        tableView.register(
            HomeRecommendCategoryTableViewCell.self,
            forCellReuseIdentifier: "HomeRecommendCategoryTableViewCell"
        )
        tableView.register(
            HomeDroppedTableViewCell.self,
            forCellReuseIdentifier: "HomeDroppedTableViewCell"
        )
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel()
        self.configureUI()
        self.addCells()
    }
}
extension HomeViewController {
    private func configureUI() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    private func addCells() {
        guard let viewModel = self.viewModel else { return }
        self.cells.append(.banner(viewModel: viewModel))
        self.cells.append(.recommendCategory(viewModel: viewModel))
        self.cells.append(.dropped(viewModel: viewModel))
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.view.frame.height / 2
        } else if indexPath.row == 1 {
            return self.view.frame.height / 3.55
        } else {
            return self.view.frame.height / 2
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("클릭")
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch self.cells[indexPath.item] {
        case .banner:
            cell.separatorInset = UIEdgeInsets(top: 0, left: self.tableView.bounds.width, bottom: 0, right: 0)
        default:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.viewModel else { return UITableViewCell() }
        switch self.cells[indexPath.item] {
        case .banner:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "HomeBannerTableViewCell"
            ) as? HomeBannerTableViewCell else {
                return UITableViewCell()
            }
            cell.setUp(viewModel)
            return cell
        case .recommendCategory:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "HomeRecommendCategoryTableViewCell"
            ) as? HomeRecommendCategoryTableViewCell else {
                return UITableViewCell()
            }
            cell.setUp(viewModel)
            return cell
        case .dropped:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "HomeDroppedTableViewCell"
            ) as? HomeDroppedTableViewCell else {
                return UITableViewCell()
            }
            cell.setUp(viewModel)
            return cell
        }
    }
}
