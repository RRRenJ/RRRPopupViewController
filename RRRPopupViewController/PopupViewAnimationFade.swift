//
//  PopupViewAnimationFade.swift
//  PopupViewControllerDemo
//
//  Created by 任敬 on 2019/9/9.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit

public class PopupViewAnimationFade: NSObject, PopupAnimationDelegate {
    
   var center : CGPoint?
   public init(_ center : CGPoint?) {
        self.center = center
    }
    
   public func animationShow(popupView: UIView, overlayView: UIView, _ isLight : Bool?) {
        if let _ = self.center {
            popupView.center = self.center!
        }else{
            popupView.center = overlayView.center
        }
        popupView.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {
            if let _ = isLight{
                if isLight! {
                    overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0)
                }else{
                    overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
                }
            }else{
                overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
            }
            
            popupView.alpha = 1
        }, completion: nil)
    }
    
   public func animationDismiss(popupView: UIView, overlayView: UIView, completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: 0.2, animations: {
            overlayView.alpha = 0
            popupView.alpha = 0
            overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0)
        }, completion: { ok in
            if ok {
                completion()
            }
        })
    }
    

}
