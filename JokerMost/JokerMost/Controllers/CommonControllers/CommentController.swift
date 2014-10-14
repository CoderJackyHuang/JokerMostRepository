//
//  CommentController.swift
//  JokerMost
//
//  Created by ljy-335 on 14-10-14.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import UIKit

///
/// @brief  查看评价信息
/// @data   2014-10-09
/// @author huangyibiao
class CommentController: BaseRefreshController {
    // 不可空
    var jokeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "评论"
        var nib = UINib(nibName: "CommentCell", bundle: nil)
        self.tableView!.registerNib(nib, forCellReuseIdentifier: "CommentCellIdentifier")
        self.tableView!.height(kScreenHeight - 64)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let root = self.tabBarController as? RootTabBarController {
            root.tabBarView?.hidden = true
        }
        
        if self.jokeId != nil {
            downloadData(urlString: "http://m2.qiushibaike.com/article/\(self.jokeId!)/comments?count=20&page=")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        if let root = self.tabBarController as? RootTabBarController {
            root.tabBarView?.hidden = false
        }
    }
    
    ///
    /// RefreshViewDelegate
    func refresh(refreshView: RefreshView, didClickButton button: UIButton) {
        if self.jokeId != nil {
            downloadData(urlString: "http://m2.qiushibaike.com/article/\(self.jokeId!)/comments?count=20&page=")
        }
    }

    ///
    /// UITableViewDataSource
    ///
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CommentCellIdentifier", forIndexPath: indexPath) as? CommentCell
        
        if indexPath.row < self.dataSource.count {
            var dataDict = self.dataSource[indexPath.row] as NSDictionary
            cell?.data = dataDict
        }

        
        return cell!
    }
    
    ///
    /// UITableViewDelegate
    ///
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        var index = indexPath.row
        var data = self.dataSource[index] as NSDictionary
        
        return  CommentCell.cellHeight(data)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 重写而已，以防调用父类的方法
    }
}
