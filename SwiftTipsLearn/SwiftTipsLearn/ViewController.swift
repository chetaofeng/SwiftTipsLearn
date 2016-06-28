//
//  ViewController.swift
//  SwiftTipsLearn
//
//  Created by chetaofeng on 16/6/24.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    deinit{
        print("释放内存")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //重载方法让单元格分割线顶头显示而不是空15像素
    override func viewDidLayoutSubviews() {
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.layoutMargins = UIEdgeInsetsZero
    }
}

