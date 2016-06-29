//
//  XGifViewController.swift
//  SwiftTipsLearn
//
//  Created by chetaofeng on 16/6/29.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class XGifViewController: UIViewController {

    @IBOutlet weak var showGifView: XGifView!
    @IBOutlet weak var showNetworkGifView: XGifView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showGifView.showGifImageByLocalName("demo")
        
        let url = NSURL(string: "http://images.17173.com/2015/news/2015/09/14/2015cpb0914gif13.gif")
        self.showNetworkGifView.showGifImageByNetwork(url!)
    }
}
