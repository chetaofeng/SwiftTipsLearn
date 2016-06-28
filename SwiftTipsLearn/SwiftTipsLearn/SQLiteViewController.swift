//
//  SQLiteViewController.swift
//  SwiftTipsLearn
//
//  Created by chetaofeng on 16/6/28.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit
import SQLite
//https://github.com/stephencelis/SQLite.swift

class SQLiteViewController: UIViewController {

    var dbConn:Connection! = nil
    let users = Table("users")
    let id = Expression<Int64>("id")
    let name = Expression<String?>("name")
    let email = Expression<String>("email")
    var tmpID:Int64!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        do{
            dbConn = try Connection(NSHomeDirectory() + "/Documents/db.sqlite3") //会自动获取或创建
            
            try dbConn.run(users.create { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(email, unique: true)
            })
        }catch{
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAction(sender: AnyObject) {
        do{
            let insert = users.insert(name <- "Alice", email <- "alice@mac.com")
            tmpID = try dbConn.run(insert)
        }catch{
            print(error)
        }
    }
    @IBAction func deleteAction(sender: AnyObject) {
        do{
            let user = users.filter(id == tmpID)
            try dbConn.run(user.delete())
        }catch{
            print(error)
        }
    }
    @IBAction func updateAction(sender: AnyObject) {
        do{
            let user = users.filter(id == tmpID)
            try dbConn.run(user.update(email <- "183822908@qq.com"))
        } catch{
            print(error)
        }
    }
    @IBAction func queryAction(sender: AnyObject) {
        do{
            for user in try dbConn.prepare(users) {
                print("id:\(user[id]),name:\(user[name]),email:\(user[email])")
            }
        }catch{
            print(error)
        }
    }
    @IBAction func countAction(sender: AnyObject) {
        let count = dbConn.scalar(users.count)
        print(count)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
