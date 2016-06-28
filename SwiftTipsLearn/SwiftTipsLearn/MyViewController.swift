//
//  MyViewController.swift
//  SwiftTipsLearn
//
//  Created by chetaofeng on 16/6/24.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class MyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!

    let testValue:NSString = "这是一些测试内容1\n这是一些测试内容2\n这是一些测试内容3\n这是一些测试内容4\n这是一些测试内容5\n这是一些测试内容6\n这是一些测试内容7\n这是一些测试内容8\n这是一些测试内容9\n这是一些测试内容10\n这是一些测试内容11\n这是一些测试内容12\n这是一些测试内容13\n"
    var dict:Dictionary<String,String> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.estimatedRowHeight = 160 //默认高度
        myTableView.rowHeight = UITableViewAutomaticDimension // 自动高度
     }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath)
        let label = cell.contentView.viewWithTag(1000) as! UILabel
        label.text = testValue as String
        if dict[String(indexPath.row)] == "0" {
            label.numberOfLines = 0
        }else{
            label.numberOfLines = 1
        }
        return cell
    }
    
    //手动设置单元格高度
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let att = [NSFontAttributeName:UIFont.systemFontOfSize(17)]
//        return testValue.boundingRectWithSize(CGSizeMake(300, 0), options: .UsesLineFragmentOrigin, attributes: att, context: nil).size.height + 10
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let label = cell!.contentView.viewWithTag(1000) as! UILabel
        myTableView.beginUpdates() //1. 代替reloadData的第一步
        if label.numberOfLines == 0 {
            label.numberOfLines = 1
            dict[String(indexPath.row)] = "1"
        }else{
            label.numberOfLines = 0
            dict[String(indexPath.row)] = "0"
        }
        myTableView.endUpdates() //2. 代替reloadData的第二步
//        myTableView.reloadData()
    }
    
    //重载方法让单元格分割线顶头显示而不是空15像素
    override func viewDidLayoutSubviews() {
        self.myTableView.separatorInset = UIEdgeInsetsZero
        self.myTableView.layoutMargins = UIEdgeInsetsZero
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
}
