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
    var springView:SpringView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animateView = UIView(frame: CGRectMake(0,0,100,100))
        self.animateView.layer.cornerRadius = 5
        self.animateView.layer.masksToBounds = true
        self.animateView.backgroundColor = UIColor.redColor()
        self.animateView.center = self.view.center
        
        self.springView = SpringView(frame: CGRectMake(0,0,200,200))
        self.springView.layer.cornerRadius = 5
        self.springView.layer.masksToBounds = true
        self.springView.backgroundColor = UIColor.blueColor()
        
        self.view.addSubview(animateView)
        self.view.addSubview(springView)
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
        
        UIView.animateKeyframesWithDuration(3, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: {
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
    
    
    @IBAction func clickedSpringAnimate(sender: AnyObject) {
        self.springView.animation = "squeeze"
        self.springView.curve = "spring"
        self.springView.duration = 1
        self.springView.animate()
    }
}

