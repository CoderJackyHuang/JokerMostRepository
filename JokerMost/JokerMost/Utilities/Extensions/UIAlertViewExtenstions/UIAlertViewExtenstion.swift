//
//  UIAlertViewExtenstion.swift
//  JokerMost
//
//  Created by ljy-335 on 14-10-9.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// @brief UIAlertView的扩展方法，方便工程全局使用扩展方法来创建或者使用提示
/// @date  2014-10-09
/// @author huangyibiao
extension UIAlertView {
    class func show(title: String = "温馨提示", message: String) {
        var alertView = UIAlertView()
        alertView.title = title
        alertView.message = message
        alertView.addButtonWithTitle("确定")
        alertView.addButtonWithTitle("取消")
        alertView.show()
    }
}