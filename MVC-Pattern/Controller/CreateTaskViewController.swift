//
//  CreateTaskViewController.swift
//  MVC-Pattern
//
//  Created by 渡邊丈洋 on 2019/03/19.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    fileprivate var createTaskView: CreateTaskView!
    
    fileprivate var dataSource: TaskDataSourse!
    fileprivate var taskText: String?
    fileprivate var taskDeadline: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.createTaskView = CreateTaskView()
        self.createTaskView.delegate = self
        self.view.addSubview(self.createTaskView)
        
        self.dataSource = TaskDataSourse()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // createTaskViewのレイアウトを設定
        self.createTaskView.frame = CGRect(
            x: self.view.safeAreaInsets.left,
            y: self.view.safeAreaInsets.top,
            width: self.view.frame.size.width - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right,
            height: self.view.frame.size.height - self.view.safeAreaInsets.bottom
        )
    }
    
    // 保存が成功した時のアラート
    fileprivate func showSaveAlert() {
        let alertController = UIAlertController(title: "保存しました", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // タスクが未入力時のアラート
    fileprivate func showMissingTaskTextAlert() {
        let alertController = UIAlertController(title: "タスクを入力してください", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { action in }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // タスクが未入力時のアラート
    fileprivate func showMissingTaskDeadlineAlert() {
        let alertController = UIAlertController(title: "締切日を入力してください", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { action in }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension CreateTaskViewController: CreateTaskViewDelegate {
    
    // タスク内容を入力している時に呼ばれるデリゲートメソッド
    func createView(taskEditting view: CreateTaskView, text: String) {
        // CreateTaskViewからタスク内容を受け取りtaskTextに代入している
        self.taskText = text
    }
    
    // 締切日時を入力している時に呼ばれるデリゲートメソッド
    func createView(deadlineEditting view: CreateTaskView, deadline: Date) {
        self.taskDeadline = deadline
    }
    
    // 保存ボタンが押された時に呼ばれるデリゲートメソッド
    func createView(saveButtonDidTap view: CreateTaskView) {
        guard let taskText = self.taskText else {
            self.showMissingTaskTextAlert()
            return
        }
        guard let taskDeadline = self.taskDeadline else {
            self.showMissingTaskDeadlineAlert()
            return
        }
        let task = Task(text: taskText, deadline: taskDeadline)
        self.dataSource.save(task: task)
        
        self.showSaveAlert()
    }
    
}
