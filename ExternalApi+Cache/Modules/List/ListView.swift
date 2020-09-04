//
//  ListView.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 04/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class ListView: UIViewController {
    var presenter: ListPresenterProtocol?
    
    var items = [ListItemModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewIsReady()
    }
    
    private func setupView() {
        title = "Posts"
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ListView: ListViewProtocol {
    func onFetchingDataError() {
        print("There was an error when fetching data")
    }
    
    func showItems(items: [ListItemModel]) {
        self.items = items
    }
}

extension ListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.itemSelected(item: items[indexPath.row])
    }
}

extension ListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].title
        guard let url = URL(string: items[indexPath.row].imageUrl), let data = try? Data(contentsOf: url) else { fatalError() }
        cell.imageView?.image = UIImage(data: data)
        return cell
    }
}
