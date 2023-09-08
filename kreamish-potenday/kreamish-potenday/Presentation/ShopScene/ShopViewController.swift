
import UIKit

class ShopViewController: UIViewController, UISearchBarDelegate {
    
    lazy var searchBar: UISearchBar = { // 검색창
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드명, 모델명, 모델번호 등"
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    }()
    
    lazy var shopTapViewController = ShopTabViewController()
    
    private func configureUI() {
        view.addSubview(searchBar)
        view.addSubview(contentView)
        view.backgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: ((statusBar?.frame.height) ?? 50) + 20
            )
        ])
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        addChild(shopTapViewController)
        shopTapViewController.view.frame = contentView.bounds
        contentView.addSubview(shopTapViewController.view)
        shopTapViewController.didMove(toParent: self)
        
        hideKeyboardWhenTappedBackground()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
