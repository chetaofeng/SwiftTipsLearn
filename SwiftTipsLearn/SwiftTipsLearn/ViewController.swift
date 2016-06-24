//
//  ViewController.swift
//  SwiftTipsLearn
//
//  Created by chetaofeng on 16/6/24.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var animateView :UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animateView = UIView(frame: CGRectMake(0,0,100,100))
        self.animateView.layer.cornerRadius = 5
        self.animateView.layer.masksToBounds = true
        self.animateView.backgroundColor = UIColor.redColor()
        self.animateView.center = self.view.center
        
        self.view.addSubview(animateView)
    }

    @IBAction func startAnimate(sender: AnyObject) {
        UIView.animateWithDuration(0.3) { 
            self.animateView.center.y -= 100
        }
        
        UIView.animateWithDuration(3, animations: {
                self.animateView.center.y -= 100
            }) { (finish) in
                self.animateView.center.y += 250
        }
        
        // 此方法中在finish的回调中一直添加动画的方式不太好，所以推荐下一种
        UIView.animateWithDuration(3, delay: 3, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animateView.center.y -= 100
            }) { (finish) in
                UIView.animateWithDuration(0.3) {
                    self.animateView.alpha = 0
                }
        }
        
        UIView.animateKeyframesWithDuration(3, delay: 3, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: { 
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1.5, animations: {
                    self.animateView.center.y -= 100
            })
            
            UIView.addKeyframeWithRelativeStartTime(1.5, relativeDuration: 1.5) {
                self.animateView.alpha = 0
            }
        }) { (finish) in
                print("animate End")
        }
    }
}

