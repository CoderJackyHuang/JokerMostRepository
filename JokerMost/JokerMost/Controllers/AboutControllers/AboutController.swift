//
//  AboutController.swift
//  JokerMost
//
//  Created by ljy-335 on 14-10-9.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import UIKit

class AboutController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关于作者"
    }

    ///
    /// 点击标哥CSDN
    @IBAction func onButtonClicked(sender: UIButton) {
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "http://blog.csdn.net/woaifen3344")) {
            UIApplication.sharedApplication().openURL(NSURL(string: "http://blog.csdn.net/woaifen3344"))
        }
    }
}
