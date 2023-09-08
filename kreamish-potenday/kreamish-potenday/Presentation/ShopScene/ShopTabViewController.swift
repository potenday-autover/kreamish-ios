
import Combine
import UIKit

import Pageboy
import Tabman

final class ShopTabViewController: TabmanViewController, PageboyViewControllerDataSource, TMBarDataSource {
//    private var viewModel: ShopTabViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    private var categoryList: [Category] = []
    private var viewControllers: [UIViewController] = []
    private lazy var tempView: UIView = {   // 상단 탭바 들어갈 자리
        return UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
    }()
    
    override func viewDidLoad() {
        // DI. 나중에 DI Container로 뺄 예정.
        let dataTransferService = DefaultDataTransferService(
            with: DefaultNetworkService(config: ApiDataNetworkConfig(baseURL: URL(string: Constants.DEFAULT_DOMAIN)!))
        )
        let categoriesRepository = DefaultCategoriesRepository(dataTransferService: dataTransferService)
        let getCategoriesUseCase = DefaultGetCategoriesUseCase(categoriesRepository: categoriesRepository)
        
        let viewModel = ShopTabViewModel(getCategoriesUseCase: getCategoriesUseCase)
        // DI. 나중에 DI Container로 뺄 예정.
        
        super.viewDidLoad()
        
        // combine. 데이터 변화를 감지함
        viewModel.$categoryList
                    .sink { [weak self] updatedCategoryList in
                        // Call your specific function in the ViewController
                        self?.categoryList = updatedCategoryList
                        self?.configureUI()
                    }
                    .store(in: &cancellables)
        
        viewModel.getCategoryList()
    }
    
    func configureUI() {
        view.addSubview(tempView)   // 상단탭 들어갈 영역
        
        for i in 0..<categoryList.count {
            viewControllers.append(ShopContentTableViewController(category: categoryList[i]))
        }

        self.dataSource = self
        self.isScrollEnabled = false    // 스와이프로 안움직이게 임시 처리.
        
        let bar = TMBar.ButtonBar()
        setTabBar(bar: bar)
        addBar(bar, dataSource: self, at: .custom(view: tempView, layout: nil)) // .custom을 통해 원하는 뷰에 삽입함.
    }
    
    func setTabBar(bar: TMBar.ButtonBar) {
        bar.backgroundView.style = .flat(color: UIColor.white)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.buttons.customize { (button) in
            button.tintColor = .black
            button.selectedTintColor = .black // 선택 되어 있을 때
            button.font = .systemFont(ofSize: 18, weight: .light)
            button.selectedFont = .boldSystemFont(ofSize: 18)
        }
        // 인디케이터 조정
        bar.indicator.weight = .light
        bar.indicator.tintColor = .black
        bar.indicator.overscrollBehavior = .compress
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = 0 // 버튼 사이 간격
        
        bar.layout.transitionStyle = .snap // Customize
    }
    
    // PageboyViewControllerDataSource
    func numberOfViewControllers(
        in pageboyViewController: Pageboy.PageboyViewController
    ) -> Int {
        viewControllers.count
    }

    func viewController(
        for pageboyViewController: Pageboy.PageboyViewController,
        at index: Pageboy.PageboyViewController.PageIndex
    ) -> UIViewController? {
        viewControllers[index]
    }

    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return .at(index: 0)
    }

    // TMBarDataSource
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        return TMBarItem(title: categoryList[index].name ?? "undefined")
    }
}
