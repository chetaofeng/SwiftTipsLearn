//
//  TestViewModel.swift
//  SwiftTipsLearn
//
//  Created by chetaofeng on 16/6/24.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class TestViewModel: NSObject,UITableViewDelegate,UITableViewDataSource {
    weak var target:TestTableView!
    
    let testValue:NSString = "这是一些测试内容1\n这是一些测试内容2\n这是一些测试内容3\n这是一些测试内容4\n这是一些测试内容5\n这是一些测试内容6\n这是一些测试内容7\n这是一些测试内容8\n这是一些测试内容9\n这是一些测试内容10\n这是一些测试内容11\n这是一些测试内容12\n这是一些测试内容13\n"
    var dict:Dictionary<String,String> = [:]
    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let label = cell!.contentView.viewWithTag(1000) as! UILabel
        self.target.beginUpdates() //1. 代替reloadData的第一步
        if label.numberOfLines == 0 {
            label.numberOfLines = 1
            dict[String(indexPath.row)] = "1"
        }else{
            label.numberOfLines = 0
            dict[String(indexPath.row)] = "0"
        }
        self.target.endUpdates() //2. 代替reloadData的第二步
        //        myTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
}
