//
//  RootTabBarController.swift
//  JokerMost
//
//  Created by ljy-335 on 14-10-9.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import UIKit

///
/// 标签栏按钮的起始标签Tag值
///
let kBarItemStartTag = 100

class RootTabBarController: UITabBarController {
    ///
    /// 成员变量声明
    ///
    var tabBarView: UIView? // 定制标签栏tabbar
    var sliderView: UIView? // 滑动视图
    
    ///
    /// 视图生命周期函数
    ///
    override func viewDidLoad() {
        super.viewDidLoad()

        // 界面布局
        configureLayout()
        // 初始化控制器
        configureControllers()
    }
    
    ///
    /// 界面UI布局铺助函数
    func configureLayout() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBar.hidden = true
        
        // 定制标签栏
        self.tabBarView = UIView(frame: CGRectMake(0, self.view.height() - 49, self.view.width(), 49))
        self.tabBarView!.backgroundColor = UIColor(red:125.0 / 255.0, green:236 / 255.0, blue:198 / 255.0, alpha: 1)
        self.view.addSubview(self.tabBarView!)
        
        // 滑块
        let width = self.view.width() / 4.0;
        self.sliderView = UIView(frame: CGRectMake(0, 0, width, 49))
        self.tabBarView!.addSubview(self.sliderView!)
        self.sliderView!.backgroundColor = UIColor(red: 251 / 255.0, green: 173 / 255.0, blue: 69 / 255.0, alpha: 1)
        
        let barItemsArray = ["最新", "热门", "真相", "关于"]
        var index = 0;
        for item in barItemsArray {
            var button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            button.frame = CGRectMake(CGFloat(index * Int(width)), 0, width, 49)
            button.tag = index + kBarItemStartTag
            button.setTitle(item, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor(red: 52 / 255.0, green: 156 / 255.0, blue: 150 / 255.0, alpha: 1),
                forState: UIControlState.Selected)
            button.addTarget(self, action: "onTabBarItemButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            self.tabBarView!.addSubview(button)
            
            button.selected = index == 0
            index++
        }
    }
    
    ///
    /// 初始化所有标签栏项对应的控制器类
    func configureControllers() {
        var latest = UINavigationController(rootViewController: LatestController())
        var hot = UINavigationController(rootViewController: HotController())
        var truth = UINavigationController(rootViewController: TruthController())
        var about = UINavigationController(rootViewController: AboutController(nibName: "AboutController", bundle: nil))
        var controllers = [latest, hot, truth, about]
        
        self .setViewControllers(controllers, animated: true)
    }
    
    ///
    /// 点击标签项切换视图
    func onTabBarItemButtonClicked(sender: UIButton!) {
        self.selectedIndex = sender.tag - kBarItemStartTag
        
        for var index = 0; index < 4; index++ {
            var button = self.tabBarView?.viewWithTag(index + kBarItemStartTag) as UIButton
            button.selected = (button.tag == index + kBarItemStartTag)
        }
        
        
        UIView.animateWithDuration(0.3, {
            // 所有类型都要求匹配，不允许任何不匹配的情况
            var x = CGFloat(self.selectedIndex) * self.view.width()
            x /= CGFloat(self.viewControllers!.count)
          self.sliderView!.originX(x)
        })
    }
}
