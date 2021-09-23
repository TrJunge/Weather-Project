//
//  ForecastViewController.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit

class ForecastViewController: UIViewController {
    
    lazy var navigationBar: UINavigationBar = setNavigationBar()
    lazy var tableView: UITableView = setTableView()
    
    var presenter: ForecastViewPresenterProtocol!
    
    let cellIdentifier = "Cell"
    let headerIdentifier = "Header"
    
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
    
    func failure() {
        
    }
}

// MARK: UITableViewDelegate
extension ForecastViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsIn(section: section)
    }
}

// MARK:  UITableViewDataSource
extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.setSectionTitle(section)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        return presenter.setCell(cell, indexPath)
    }
}
