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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.taskTextField.frame = CGRect(x: bounds.origin.x + 30, y: bounds.origin.y + 30, width: bounds.size.width - 60, height: 50)
        
        self.deadlineTextField.frame = CGRect(x: self.taskTextField.frame.origin.x, y: self.taskTextField.frame.maxY + 30, width: self.taskTextField.frame.size.width, height: self.taskTextField.frame.size.height)
        
        let saveButtonSize = CGSize(width: 100, height: 50)
        self.saveButton.frame = CGRect(x: (bounds.size.width - saveButtonSize.width) / 2, y: self.deadlineTextField.frame.maxY + 20, width: saveButtonSize.width, height: saveButtonSize.height)
        
    }
    
}

extension CreateTaskView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.createView(taskEditting: self, text: textField.text ?? "")
        return true
    }
}
