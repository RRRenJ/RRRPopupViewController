//
//  PopupViewController.swift
//  PopupViewControllerDemo
//
//  Created by 任敬 on 2019/9/9.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit

public protocol PopupAnimationDelegate : NSObjectProtocol {
    func animationShow(popupView:UIView, overlayView:UIView, _ isLight:Bool?)
    func animationDismiss(popupView:UIView, overlayView:UIView, completion: @escaping (() -> Void))
}



public extension UIViewController {

    private struct TagKey {
        static var popupViewTag : Int = 1314
        static var overPopupViewTag : Int = 1315
    }
    
    func presentPopupView(popupView:UIView, animation:PopupAnimationDelegate, backgroundClickable:Bool?, isLight: Bool?, dismiss:(() -> Void)?) {
        if let _ = self.overPopupView {
            if self.overPopupView!.subviews.contains(popupView) {
                return
            }
            if self.overPopupView!.subviews.count > 1 {
                self.dismissPopupView(animation: nil)
            }
        }
        self.popupView = nil
        self.popupView = popupView
        self.popupAnimation = nil
        self.popupAnimation = animation
        
        let sourceView = self.topView()
        
        popupView.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin ]
        popupView.tag = TagKey.popupViewTag
        popupView.layer.shouldRasterize = true
        popupView.layer.rasterizationScale = UIScreen.main.scale
        
        if self.overPopupView == nil{
            let overlayView = UIView(frame: sourceView.bounds)
            overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            overlayView.tag = TagKey.overPopupViewTag
            overlayView.backgroundColor = UIColor.clear
            
            let backgroundView = UIView(frame: sourceView.bounds)
            backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            overlayView.addSubview(backgroundView)
            overlayView.popBackgroundView = backgroundView
            
            if let _ = backgroundClickable {
                if backgroundClickable! {
                    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
                    backgroundView.addGestureRecognizer(tap)
                }
            }
            self.overPopupView = overlayView
        }
        self.overPopupView!.addSubview(popupView)
        sourceView.addSubview(self.overPopupView!)
        
        self.overPopupView!.alpha = 1
        popupView.center = self.overPopupView!.center
        animation.animationShow(popupView: popupView, overlayView: self.overPopupView!, isLight)
        self.dismissCallback = dismiss
        
    }
    
    func dismissPopupView() {
        self.dismissPopupView(animation: self.popupAnimation)
    }
    
    private func dismissPopupView(animation:PopupAnimationDelegate?)  {

        if let _ = self.popupView, let _ = self.overPopupView {
            if let _ = animation {
                animation!.animationDismiss(popupView: self.popupView!, overlayView: self.overPopupView!, completion: {
                    self.overPopupView!.removeFromSuperview()
                    self.popupView?.removeFromSuperview()
                    self.popupView = nil
                    self.popupAnimation = nil
                    let dissmiss = self.dismissCallback
                    if let _ = dissmiss {
                        dissmiss!()
                        self.dismissCallback = nil
                    }
                })
            }else{
                self.overPopupView!.removeFromSuperview()
                self.popupView?.removeFromSuperview()
                self.popupView = nil
                self.popupAnimation = nil
                let dissmiss = self.dismissCallback
                if let _ = dissmiss {
                    dissmiss!()
                    self.dismissCallback = nil
                }
            }
        }
    }
    
    @objc private  func dismissView() {
        self.dismissPopupView(animation: self.popupAnimation)
    }
    
    func topView() -> UIView {
        var recentVC = self
        while recentVC.parent != nil {
            recentVC = recentVC.parent!
        }
       return recentVC.view
    }

}

public extension  UIViewController {
    
    private struct AssociatedKey {
        static var popupView : String = "popupView"
        static var overPopupView : String = "overPopupView"
        static var popupAnimation : String = "popupAnimation"
        static var dismissCallback : String = "dismissCallback"
        static var isLight : String = "isLight"
    }
    
   private var popupView : UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.popupView) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.popupView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
   private var overPopupView : UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.overPopupView) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.overPopupView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
   private weak var popupAnimation : PopupAnimationDelegate? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.popupAnimation) as? PopupAnimationDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.popupAnimation, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var dismissCallback : (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.dismissCallback) as? (() -> Void)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.dismissCallback, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
}

extension UIView {
    
    private struct AssociatedKey {
        static var popupViewController : String = "popupViewController"
        static var backgroundView : String = "backgroundView"
    }
    
    var popupViewController : UIViewController? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.popupViewController) as? UIViewController
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.popupViewController, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    var popBackgroundView : UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.backgroundView) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.backgroundView, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

