//
//  XCache.swift
//  SwiftTipsLearn
//
//  Created by chetaofeng on 16/6/28.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class XCache: NSObject {
    /**
     获取缓存大小
     
     - returns: 返回缓存大小
     */
    static func getCacheSize() -> String {
        return String(format:"%.2fMB",XCache.getFolderSizeAtPath(NSHomeDirectory()))
    }
    
    /**
     获取单个文件数目 MB
     
     - parameter path: 文件位置
     
     - returns: 文件数目
     */
    static func getFileSize(path:String) -> Double {
        var size:Double = 0
        let manager = NSFileManager.defaultManager()
        do{
            size = try manager.attributesOfItemAtPath(path)["NSFileSize"] as! Double
        }catch{
            print(error)
        }
        return size/1024/1024
    }
    
    /**
     *  获取特定文件夹大小
     *
     *  @param path:String 文件夹路径
     *
     *  @return 文件夹大小
     */
    static func getFolderSizeAtPath(folderPath:String) -> Double {
        var size:Double = 0
        let manager = NSFileManager.defaultManager()
        if !manager.fileExistsAtPath(folderPath) {
            return 0
        }
        
        let childFilesPath = manager.subpathsAtPath(folderPath)
        for path in childFilesPath! {
            size += XCache.getFileSize(folderPath + "/" + path)
        }
        
        return size
    }
    
    static func cleanCache(completion:() -> Void){
        XCache.deleteFolder(NSHomeDirectory() + "/Documents")
        XCache.deleteFolder(NSHomeDirectory() + "/Library")
        XCache.deleteFolder(NSHomeDirectory() + "/tmp")
        
        completion()
    }
    static func deleteFile(path:String) {
        let manager = NSFileManager.defaultManager()
        do{
            try manager.removeItemAtPath(path)
        }catch{
            print(error)
        }
    }
    static func deleteFolder(folderPath:String) {
        let manager = NSFileManager.defaultManager()
        if manager.fileExistsAtPath(folderPath) {
            let childFilesPath = manager.subpathsAtPath(folderPath)
            for path in childFilesPath! {
                XCache.deleteFile(folderPath + "/" + path)
            }
        }
    }
}
