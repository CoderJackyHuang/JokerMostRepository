//
//  RefreshView.swift
//  JokerMost
//
//  Created by ljy-335 on 14-10-9.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// @brief 刷新代理声明
/// @author huangyibiao
///
@objc protocol RefreshViewDelegate {
    ///
    /// @brief 回调此方法来执行刷新
    /// @param refreshView 代理遵守者
    /// @param didClickButton 点击的按钮对象
    optional func refresh(refreshView: RefreshView, didClickButton button: UIButton)
}

class RefreshView: UIView {
    /// 加载更多按钮
    @IBOutlet weak var loadMoreButton: UIButton!
    /// 转圈圈视图
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var delegate: RefreshViewDelegate?
    
    ///
    /// 点击加载更多按钮的回调方法
    @IBAction func onLoadMoreButtonClicked(sender: UIButton) {
        self.delegate?.refresh?(self, didClickButton: sender)
    }
    
    ///
    /// 生命周期函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.loadingIndicator?.hidden = true
        self.loadMoreButton.setTitle("点击加载更多", forState: UIControlState.Normal)
    }
    
    ///
    /// 开始加载
    func startLoadingMore() {
        self.loadMoreButton.setTitle("", forState: UIControlState.Normal)
        self.loadingIndicator.hidden = false
        self.loadingIndicator.startAnimating()
    }
    
    ///
    /// 停止加载
    func stopLoadingMore() {
        self.loadMoreButton.setTitle("点击加载更多", forState: UIControlState.Normal)
        self.loadingIndicator.hidden = true
        self.loadingIndicator.stopAnimating()
    }
}