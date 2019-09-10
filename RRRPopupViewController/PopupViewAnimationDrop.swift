//
//  PopupViewAnimationDrop.swift
//  PopupViewControllerDemo
//
//  Created by 任敬 on 2019/9/9.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit

open class PopupViewAnimationDrop: NSObject, PopupAnimationDelegate{

   public func animationShow(popupView: UIView, overlayView: UIView, _ isLight: Bool?) {
        popupView.center = CGPoint(x: overlayView.center.x, y: -popupView.bounds.height / 2)
        popupView.transform = CGAffineTransform(rotationAngle: -CGFloat(M_1_PI)/2)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            popupView.transform = CGAffineTransform(rotationAngle: 0)
            popupView.center = overlayView.center
            if let _ = isLight {
                if isLight! {
                    overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0)
                }else{
                    overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
                }
            }else{
                overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
            }
            
        }, completion: nil)
    }
    
   public func animationDismiss(popupView: UIView, overlayView: UIView, completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            overlayView.alpha = 0
            popupView.center = CGPoint(x: overlayView.center.x, y: overlayView.bounds.height + popupView.bounds.height)
            popupView.transform = CGAffineTransform(rotationAngle: CGFloat(M_1_PI) / 1.5)
            overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0)
            
        }, completion: { _ in
            completion()
        })
    }
    

}
