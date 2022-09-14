//
//  HomeViewController.swift
//  ShoppingList
//
//  Created by Habip Yesilyurt on 11.09.2022.
//

import UIKit

class HomeViewController: UIViewController {
    private let shoppingCountLabel: UILabel = UILabel()
    private let textView: UITextView = UITextView()
    private var shopppins: [ShoppingLists] = []
    weak var delegate: HomeViewControllerDelegate?
    
    lazy var homeViewModel = HomeViewModel(with: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        //configureTextView()
        //configureShoppingCountLabel()
        homeViewModel.fetcData()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTopMenuButton))
        
    }
    
    func homeViewIsLoad() {
        self.navigationItem.rightBarButtonItem = nil
        configureShoppingCountLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("changeData"), object: nil)
        configureShoppingCountLabel()
    }

        
    @objc func getData() {
        homeViewModel.fetcData()
    }
    
    @objc func didTopMenuButton() {
        delegate?.didTopMenuButton()
    }
    
    private func configureTextView() {
        view.addSubview(textView)
        let attributedString = NSMutableAttributedString(string: "Click here")
        //"ShoppingList://GoToShoppingListScreen"
        //"https://www.hackingwithswift.com"
        attributedString.addAttribute(.link, value: "ShoppingList://GoToShoppingListScreen", range: NSRange(location: 0, length: 7))
        textView.attributedText = attributedString
        textView.textColor = .black
        textView.backgroundColor = .systemBackground
        setTextViewConstraints()
    }
    
    private func setTextViewConstraints() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    private func configureShoppingCountLabel() {
        view.addSubview(shoppingCountLabel)
        //textView.addSubview(shoppingCountLabel)
    
        shoppingCountLabel.text = shopppins.count > 0 ? "You have \(shopppins.count) Shopping List." : "You don't have Shopping List yet. Create with menu."

        shoppingCountLabel.adjustsFontSizeToFitWidth = false
        shoppingCountLabel.numberOfLines = 0
        shoppingCountLabel.textAlignment = .center
        setShoppingCountLabelConstraints()
    }
    
    private func setShoppingCountLabelConstraints() {
        shoppingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        shoppingCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shoppingCountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        shoppingCountLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        shoppingCountLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }

}

extension HomeViewController: HomeViewModelDelegate {
    func fetchShoppingLists(shoppingLists: [ShoppingLists]) {
        self.shopppins = shoppingLists
    }
}


extension HomeViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        UIApplication.shared.open(URL)
//        return false
        if URL.absoluteString == "ShoppingList://GoToShoppingListScreen" {
            print("ifffffff")
            
            let shoppingListVC =  ShoppingListViewController()
            navigationController?.pushViewController(shoppingListVC, animated: true)
            return false
        } else {
            print("elseeee")
        }
        return true
    }
}
