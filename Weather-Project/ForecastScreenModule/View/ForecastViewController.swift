//
//  ForecastViewController.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit

class ForecastViewController: UIViewController {
    private lazy var navigationBar: UINavigationBar = setNavigationBar()
    private lazy var tableView: UITableView = setTableView()
    var presenter: ForecastViewPresenterProtocol?
    
    private let cellIdentifier = "Cell"
    private let headerIdentifier = "Header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "background-color")
        setupSubview()
        setupConstraint()
    }
}

// MARK: ForecastViewProtocol
extension ForecastViewController: ForecastViewProtocol {
    func success(navigationBarTitle: String) {
        guard let navItem = navigationBar.items?[0] else { return }
        navItem.title = navigationBarTitle
        tableView.reloadData()
    }
    
    func failure() {}
}

// MARK: UITableViewDelegate
extension ForecastViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.sectionCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsIn(section: section) ?? 0
    }
}

// MARK:  UITableViewDataSource
extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter?.setSectionTitle(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) else {
            return UITableViewHeaderFooterView()
        }
        headerView.tintColor = UIColor(named: "background-color")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CGFloat(35.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell,
              let presenter = presenter else {
            return UITableViewCell()
        }
        return presenter.setCell(cell, indexPath)
    }
}

// MARK: setupSubviews and setupConstraint
private extension ForecastViewController {
    func setNavigationBar() -> UINavigationBar {
        let navBar = UINavigationBar()
        navBar.prefersLargeTitles = false
        navBar.isTranslucent = false
        navBar.barTintColor = UIColor(named: "background-color")
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem()
        navBar.setItems([navItem], animated: true);
        return navBar
    }
    
    func setTableView() -> UITableView {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.backgroundColor = UIColor(named: "background-color")
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
    
    func setupSubview() {
        view.addSubview(navigationBar)
        view.addSubview(tableView)
    }
    
    func setupConstraint() {
        navigationBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
