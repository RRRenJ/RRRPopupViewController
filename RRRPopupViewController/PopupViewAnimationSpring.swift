//
//  PopupViewAnimationSpring.swift
//  PopupViewControllerDemo
//
//  Created by 任敬 on 2019/9/9.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit

open class PopupViewAnimationSpring: NSObject, PopupAnimationDelegate, CAAnimationDelegate {
    
    var completion : (() -> Void)?
    

   public func animationShow(popupView: UIView, overlayView: UIView, _ isLight : Bool?) {
        popupView.alpha = 1
        let popAnimation = CAKeyframeAnimation(keyPath: "transform")
        popAnimation.duration = 0.4
        popAnimation.values = [NSValue(caTransform3D: CATransform3DMakeScale(0.01, 0.01, 1)),
                                NSValue(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1)),
                                NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1)),
                                NSValue(caTransform3D: CATransform3DIdentity)]
        popAnimation.keyTimes = [NSNumber(value: 0.2),NSNumber(value: 0.5),NSNumber(value: 0.75),NSNumber(value:1)]
        popAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)]
        popupView.layer.add(popAnimation, forKey: nil)
        UIView.animate(withDuration: 0.4) {
            if let _ = isLight {
                if isLight! {
                    overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0)
                }else{
                    overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
                }
            }else{
                overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
            }
        }
    }
    
   public func animationDismiss(popupView: UIView, overlayView: UIView, completion: @escaping (() -> Void)) {
        self.completion = completion
        UIView.animate(withDuration: 0.4) {
            overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0)
            overlayView.alpha = 0
        }
        let hideAnimation = CAKeyframeAnimation(keyPath: "transform")
        hideAnimation.duration = 0.4
        hideAnimation.values = [NSValue(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1)),
                               NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1)),
                               NSValue(caTransform3D: CATransform3DMakeScale(0.0, 0.0, 1)),
                               NSValue(caTransform3D: CATransform3DIdentity)]
        hideAnimation.keyTimes = [NSNumber(value: 0.2),NSNumber(value: 0.5),NSNumber(value: 0.75),NSNumber(value:1)]
        hideAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)]
        hideAnimation.delegate = self
        popupView.layer.add(hideAnimation, forKey: nil)
    }
    
   public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let _ = self.completion {
            self.completion!()
        }
        
    }
    
    
    
}
