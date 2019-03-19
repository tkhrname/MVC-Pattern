//
//  TaskListViewController.swift
//  MVC-Pattern
//
//  Created by 渡邊丈洋 on 2019/03/13.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {
    
    var dataSource: TaskDataSourse!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = TaskDataSourse()
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.register(TaskListCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataSource.loadData()
        self.tableView.reloadData()
    }
    
    @objc func barButtonTapped(_ sender: UIBarButtonItem) {
        // タスク作成画面へ遷移
        let controller = CreateTaskViewController()
        let navi = UINavigationController(rootViewController: controller)
        self.present(navi, animated: true, completion: nil)
    }
    
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TaskListCell else { return UITableViewCell() }
        let task = self.dataSource.data(at: indexPath.row)
        cell.task = task
        return cell
    }
    
}

extension TaskListViewController: UITableViewDelegate {
    
}
