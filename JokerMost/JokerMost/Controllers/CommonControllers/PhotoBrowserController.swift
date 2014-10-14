//
//  PhotoBrowserController.swift
//  JokerMost
//
//  Created by ljy-335 on 14-10-14.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import UIKit

/// 获取屏幕的宽
let kScreenWidth = UIScreen.mainScreen().bounds.size.width
/// 获取屏幕的高
let kScreenHeight = UIScreen.mainScreen().bounds.size.height

///
/// @brief  大图查看 视图控制器类
/// @data   2014-10-14
/// @author huangyibiao
class PhotoBrowserController: UIViewController {
    /// 大图图片路径
    var bigImageUrlString: String?
    var imageView: UIImageView?
    var indicator = UIActivityIndicatorView()
    var isOpen = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "图片"
        
        // image
        imageView = UIImageView(frame: self.view.bounds)
        self.view.addSubview(imageView!)
        imageView!.userInteractionEnabled = true
        imageView!.backgroundColor = UIColor.blackColor()
        var tap = UITapGestureRecognizer(target: self, action: "onTapImageView:")
        imageView!.addGestureRecognizer(tap)
        
        let rotate = UIRotationGestureRecognizer(target: self, action: "onRotateImageView:")
        imageView!.addGestureRecognizer(rotate)
        
        let pin = UIPinchGestureRecognizer(target: self, action: "onPinImageView:")
        imageView!.addGestureRecognizer(pin)
        
        // indicator
        self.indicator.frame = CGRectMake((kScreenWidth - 80) / 2, (kScreenHeight - 64 - 80) / 2 , 80, 80)
        self.view.addSubview(self.indicator)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let root = self.tabBarController as? RootTabBarController {
            root.tabBarView?.hidden = true
        }
        
        self.indicator.startAnimating()
        self.imageView!.sd_setImageWithURL(NSURL(string: self.bigImageUrlString!), completed: {
            (image, error, type, url) -> Void in
            self.imageView!.image = image
            self.indicator.stopAnimating()
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 恢复原始状态
        self.imageView!.transform = CGAffineTransformIdentity
        
        if let root = self.tabBarController as? RootTabBarController {
            root.tabBarView?.hidden = false
        }
    }
    
    ///
    /// Event handle functions
    ///
    func onTapImageView(tap: UITapGestureRecognizer) {
        if self.isOpen {
            self.navigationController?.navigationBarHidden = true
            self.isOpen = false
        } else {
            self.navigationController?.navigationBarHidden = false
            self.isOpen = true
        }
    }
    
    ///
    /// 旋转手势
    func onRotateImageView(rotate: UIRotationGestureRecognizer) {
        self.imageView!.transform = CGAffineTransformRotate(self.imageView!.transform, rotate.rotation)
        
        // 旋转完成后，必须重新设置成0，表示未旋转前
        rotate.rotation = 0
    }
    
    ///
    /// 放大或者缩小手势
    func onPinImageView(pin: UIPinchGestureRecognizer) {
        self.imageView!.transform = CGAffineTransformScale(self.imageView!.transform, pin.scale, pin.scale)
        
        // 放大或者缩小完成后，必须重新设置成1.0，表示未缩放前
        pin.scale = 1.0
    }
}
