//
//  FilterPopupTabViewController.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/06/25.
//

import UIKit

import Pageboy
import Tabman

class FilterPopupTabViewController: TabmanViewController, PageboyViewControllerDataSource, TMBarDataSource {
    var viewModel: FilterViewModel?
    private var viewControllers: [UIViewController] = []
    
    private lazy var tabView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        FilterPopupTabViewController.filterPopupTabViewHeight = view.bounds.height
        return view
    }()
    static var filterPopupTabViewHeight = 0.0
    
    let contentTableViewController1 = FilterPopupContentTableViewController()
    let contentTableViewController2 = FilterPopupContentTableViewController()
    let contentTableViewController3 = FilterPopupContentTableViewController()
    let contentTableViewController4 = FilterPopupContentTableViewController()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    init(viewModel: FilterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        
        view.addSubview(tabView)   // 상단탭 들어갈 영역
        
        guard let viewModel = self.viewModel else {
            return
        }
        for i in 0..<viewModel.filterList.count {
            let contentTableViewController = FilterPopupContentTableViewController()
            contentTableViewController.setUp(viewModel: FilterViewModel(selectedFilterId: i))
            viewControllers.append(contentTableViewController)
            
        }
        
        self.dataSource = self
        self.isScrollEnabled = false    // 스와이프로 안움직이게 처리
        
        let bar = TMBar.ButtonBar()
        setTabBar(bar: bar)
        addBar(bar, dataSource: self, at: .custom(view: tabView, layout: nil)) // .custom을 통해 원하는 뷰에 삽입함.
    }
    
    func setTabBar(bar: TMBar.ButtonBar) {
        bar.backgroundView.style = .flat(color: UIColor.white)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.buttons.customize { (button) in
            button.tintColor = .lightGray
            button.selectedTintColor = .black // 선택 되어 있을 때
            button.font = .systemFont(ofSize: 18, weight: .medium)
            button.selectedFont = .boldSystemFont(ofSize: 18)
        }
        // 인디케이터 조정
        bar.indicator.weight = .custom(value: 0)
        bar.indicator.overscrollBehavior = .compress
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = 0 // 버튼 사이 간격
        
        bar.layout.transitionStyle = .snap // Customize
    }
    
    // MARK: Pageboy DataSource, Tabman DataSource
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        guard let viewModel = self.viewModel else {
            return .at(index: 0)
        }
        return .at(index: viewModel.selectedFilterId)
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        guard let viewModel = self.viewModel else {
            return TMBarItem(title: "error")
        }
        return TMBarItem(title: viewModel.filterList[index].name)
    }
}
