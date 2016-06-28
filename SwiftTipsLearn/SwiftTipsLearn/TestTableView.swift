//
//  TestTableView.swift
//  SwiftTipsLearn
//
//  Created by chetaofeng on 16/6/24.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class TestTableView: UITableView {
    var vm:TestViewModel! = TestViewModel()
    
    override func awakeFromNib() {
        self.estimatedRowHeight = 160 //默认高度
        self.rowHeight = UITableViewAutomaticDimension // 自动高度
        vm.target = self
        self.delegate = vm
        self.dataSource = vm
    }
    
}
