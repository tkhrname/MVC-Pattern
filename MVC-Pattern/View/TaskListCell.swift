//
//  TaskListCell.swift
//  MVC-Pattern
//
//  Created by 渡邊丈洋 on 2019/03/11.
//  Copyright © 2019 渡邊丈洋. All rights reserved.
//

import UIKit

class TaskListCell: UITableViewCell {
    
    private var taskLabel: UILabel!
    private var deadlineLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.taskLabel = UILabel()
        self.taskLabel.textColor = .black
        self.taskLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(self.taskLabel)
        
        self.deadlineLabel = UILabel()
        self.deadlineLabel.textColor = .black
        self.deadlineLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(self.deadlineLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.taskLabel.frame = CGRect(x: 15.0, y: 15.0, width: self.contentView.frame.width - 30, height: 15.0)
        self.deadlineLabel.frame = CGRect(x: self.taskLabel.frame.origin.x, y: self.taskLabel.frame.maxY + 8, width: self.taskLabel.frame.width, height: 15.0)
    }
    
    var task: Task? {
        didSet {
            guard let t = task else { return }
            self.taskLabel.text = t.text
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            self.deadlineLabel.text = formatter.string(from: t.deadline)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
