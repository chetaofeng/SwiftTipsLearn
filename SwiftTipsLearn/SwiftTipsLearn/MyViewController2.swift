//
//  MyViewController.swift
//  SwiftTipsLearn
//
//  Created by chetaofeng on 16/6/24.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class MyViewController2: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 160 //默认高度
        tableView.rowHeight = UITableViewAutomaticDimension // 自动高度
        tableView.tableFooterView = UIView()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath)
       
        let bottomView = cell.contentView.viewWithTag(2000)
        let imageView = bottomView?.viewWithTag(2001)
        let rect = bottomView?.convertRect((bottomView?.bounds)!, toView: nil) //获取相对屏幕的位置
        var y = UIScreen.mainScreen().bounds.size.height - (rect?.origin.y)! - 400
//        y = y * 0.2 //让移动速度变慢
        if y > 0 {
            y = 0
        }else{
            y = -100
        }
        imageView?.frame.origin.y = y

        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for cell in tableView.visibleCells {  //屏幕显示的cell
            let bottomView = cell.contentView.viewWithTag(2000)
            let imageView = bottomView?.viewWithTag(2001)
            let rect = bottomView?.convertRect((bottomView?.bounds)!, toView: nil) //获取相对屏幕的位置
            var y = UIScreen.mainScreen().bounds.size.height - (rect?.origin.y)! - 600
            y = y * 0.2 //让移动速度变慢
            if y > 0 {
                y = 0
            }else{
                y = -100
            }
            imageView?.frame.origin.y = y
        }
    }
}
