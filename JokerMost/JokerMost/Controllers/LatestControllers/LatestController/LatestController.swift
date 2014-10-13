//
//  LatestController.swift
//  JokerMost
//
//  Created by ljy-335 on 14-10-9.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// @brief 最新 模块视图控制器
/// @author huangyibiao
class LatestController: BaseRefreshController {
    ///
    /// @brief 生命周期函数
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "最新";
        downloadData(urlString: "http://m2.qiushibaike.com/article/list/latest?count=20&page=")
    }
    
    ///
    /// RefreshViewDelegate
    func refresh(refreshView: RefreshView, didClickButton button: UIButton) {
        downloadData(urlString: "http://m2.qiushibaike.com/article/list/latest?count=20&page=")
    }
}