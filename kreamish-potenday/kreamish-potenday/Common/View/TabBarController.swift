import UIKit

final class TabBarController: UITabBarController {
    private lazy var homeViewController: UIViewController = {
        let viewController = HomeViewController()
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .black)
        let normalImage = UIImage(systemName: "house", withConfiguration: imageConfiguration)
        let selectedImage = UIImage(systemName: "house.fill", withConfiguration: imageConfiguration)
        let tabBarItem = UITabBarItem(title: "HOME", image: normalImage, tag: 0)
        tabBarItem.selectedImage = selectedImage
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    private lazy var shopViewNavigationController: UINavigationController = {
        let shopViewNavigationController  = UINavigationController(rootViewController: ShopViewController())
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .black)
        let normalImage = UIImage(systemName: "magnifyingglass.circle", withConfiguration: imageConfiguration)
        let selectedImage = UIImage(systemName: "magnifyingglass.circle.fill", withConfiguration: imageConfiguration)
        let tabBarItem = UITabBarItem(title: "SHOP", image: normalImage, tag: 1)
        tabBarItem.selectedImage = selectedImage
        shopViewNavigationController.tabBarItem = tabBarItem
        return shopViewNavigationController
    }()
    
    private lazy var myViewController: UIViewController = {
        let viewController = UIViewController()
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .black)
        let normalImage = UIImage(systemName: "person", withConfiguration: imageConfiguration)
        let selectedImage = UIImage(systemName: "person.fill", withConfiguration: imageConfiguration)
        let tabBarItem = UITabBarItem(title: "MY", image: normalImage, tag: 2)
        tabBarItem.selectedImage = selectedImage
        viewController.tabBarItem = tabBarItem
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

private extension TabBarController {
    func configureUI() {
        self.viewControllers = [homeViewController, shopViewNavigationController, myViewController]
        self.tabBar.tintColor = .black
    }
}
