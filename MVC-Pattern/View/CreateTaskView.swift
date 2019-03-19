//
//  CreateTaskView.swift
//  MVC-Pattern
//
//  Created by 渡邊丈洋 on 2019/03/19.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import UIKit

// CreateTaskViewControllerへユーザーインタラクションを伝達するためのプロトコル
protocol CreateTaskViewDelegate: class {
    func createView(taskEditting view: CreateTaskView, text: String)
    func createView(deadlineEditting view: CreateTaskView, deadline: Date)
    func createView(saveButtonDidTap view: CreateTaskView)
}

class CreateTaskView: UIView {

    private var taskTextField: UITextField!
    private var datePicker: UIDatePicker!
    private var deadlineTextField: UITextField!
    private var saveButton: UIButton!
    
    weak var delegate: CreateTaskViewDelegate?
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.taskTextField = UITextField()
        self.taskTextField.delegate = self
        self.taskTextField.tag = 0
        self.taskTextField.placeholder = "予定を入れてください"
        self.addSubview(self.taskTextField)
        
        self.deadlineTextField = UITextField()
        self.deadlineTextField.tag = 1
        self.deadlineTextField.placeholder = "期限を入れてください"
        self.addSubview(self.deadlineTextField)
        
        self.datePicker = UIDatePicker()
        self.datePicker.datePickerMode = .dateAndTime
        self.datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        // deadlineTextFieldが編集モードになった時に、キーボードではなくUIDatePickerになるようにする
        self.deadlineTextField.inputView = self.datePicker
        
        self.saveButton = UIButton()
        self.saveButton.setTitle("保存する", for: .normal)
        self.saveButton.setTitleColor(.black, for: .normal)
        self.saveButton.layer.borderWidth = 0.5
        self.saveButton.layer.cornerRadius = 4.0
        self.saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(self.saveButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let deadlineText = dateFormatter.string(from: sender.date)
        self.deadlineTextField.text = deadlineText
        self.delegate?.createView(deadlineEditting: self, deadline: sender.date)
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        self.delegate?.createView(saveButtonDidTap: self)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
    }
    */

}

extension CreateTaskView: UITextFieldDelegate {
    
}
