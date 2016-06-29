//
//  XGifView.swift
//  SwiftTipsLearn
//
//  Created by chetaofeng on 16/6/29.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit
import ImageIO
import QuartzCore

class XGifView: UIView {

//    UIView的宽高
    var width:CGFloat{return self.frame.size.width}
    var height:CGFloat{return self.frame.size.height}
    
    private var gifURL:NSURL!
    private var imageArr:Array<CGImage> = []
    private var totalTime:Float = 0
    private var timeArr:Array<NSNumber> = []
    
    /**
     显示本地gif文件
     
     - parameter name: 本地gif文件名称
     */
    func showGifImageByLocalName(name:String){
        gifURL = NSBundle.mainBundle().URLForResource(name, withExtension: "gif")
        self.createFrame()
    }
    /**
     显示网络gif文件
     由于网络gif需下载之后再解析，比较慢，看效果需耐心等待
     - parameter url: 网络gif文件路径
     */
    func showGifImageByNetwork(url:NSURL) {
        let fileName = self.getMD5String(url.absoluteString)
        let cacheFilePath = NSHomeDirectory() + "/Library/Caches/" + fileName + ".gif"
        let manager = NSFileManager.defaultManager()
        if manager.fileExistsAtPath(cacheFilePath){
            self.gifURL = NSURL(fileURLWithPath: cacheFilePath)
            self.createFrame()
        }else{
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url) { (data, response, error) in
                if (error != nil) {
                    print(error)
                    return
                }
                data?.writeToFile(cacheFilePath, atomically: true)
                self.gifURL = NSURL(fileURLWithPath: cacheFilePath)
                self.createFrame()
            }
            task.resume()
        }
    }
    /**
     解析gif图片的时间和帧信息
     */
    func createFrame() {
        let url:CFURLRef = gifURL as CFURLRef
        let gifSource = CGImageSourceCreateWithURL(url, nil)
        if gifSource != nil {
            let imageCount = CGImageSourceGetCount(gifSource!)
            for i in 0..<imageCount {
                let imageRef = CGImageSourceCreateImageAtIndex(gifSource!,i,nil)
                imageArr.append(imageRef!)
                let sourceDict = CGImageSourceCopyPropertiesAtIndex(gifSource!,i, nil) as NSDictionary!
                let imageWidth = sourceDict![String(kCGImagePropertyPixelWidth)] as! NSNumber
                let imageHeight = sourceDict![String(kCGImagePropertyPixelHeight)] as! NSNumber
                if CGFloat(imageWidth.floatValue/imageHeight.floatValue) != width/height {
                    self.fitScale(CGFloat(imageWidth.floatValue), imageHeight:CGFloat(imageHeight.floatValue))
                }
                let gifDict = sourceDict[String(kCGImagePropertyGIFDictionary)]
                let time = gifDict![String(kCGImagePropertyGIFUnclampedDelayTime)] as! NSNumber
                totalTime += time.floatValue
                timeArr.append(time)
            }
            self.showAnimation()
        }
    }
    
    /**
     显示动画
     */
    func showAnimation(){
        let animation = CAKeyframeAnimation(keyPath: "contents")
        var current:Float = 0
        var timeKeys:Array<NSNumber> = []
        for time in timeArr {
            timeKeys.append(NSNumber(float:Float(current/totalTime)))
            current += time.floatValue
        }
        animation.keyTimes = timeKeys
        animation.values = imageArr
        animation.duration = NSTimeInterval(totalTime)
        animation.repeatCount = HUGE
        animation.removedOnCompletion = false
        self.layer.addAnimation(animation, forKey: "XGifView")
    }

    /**
     适应gif图片比例，防止变形
     
     - parameter imageWidth:  帧图像宽度
     - parameter imageHeight: 帧图像高度
     */
    func fitScale(imageWidth:CGFloat,imageHeight:CGFloat) {
        var newWidth:CGFloat
        var newHeight:CGFloat
        if imageWidth/imageHeight > width/height {
            newHeight = width/(imageWidth/imageHeight)
            newWidth = width
        }else {
            newHeight = height
            newWidth = height*(imageWidth/imageHeight)
        }
        let point:CGPoint = self.center //记录改变前的中心位置
        self.frame.size = CGSizeMake(newWidth, newHeight)
        self.center = point // 保持中心位置不变
    }
    
    func getMD5String(tmp:String) -> String{
        let str = tmp.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(tmp.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digtLen = Int(CC_MD5_DIGEST_LENGTH)
        let res = UnsafeMutablePointer<CUnsignedChar>.alloc(digtLen)
        CC_MD5(str!, strLen, res)
        let hash = NSMutableString()
        for i in 0..<digtLen {
            hash.appendFormat("%02x",res[i])
        }
        res.destroy()
        return String(format: hash as String)
    }
}
