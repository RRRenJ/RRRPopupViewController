//
//  PopupViewAnimationSlide.swift
//  PopupViewControllerDemo
//
//  Created by 任敬 on 2019/9/9.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit

public enum PopupAnimationSlideType {
    case bottomTop
    case bottomBottom
    case topTop
    case topBottom
    case leftLeft
    case leftRight
    case rightLeft
    case rightRight
}

public protocol PopupViewAnimationSlideDelegate : NSObjectProtocol {
    func popupViewWillDismiss()
}



open class PopupViewAnimationSlide: NSObject, PopupAnimationDelegate {
    
   
    
    var origin : Origin?
    var type : PopupAnimationSlideType
    weak var delegate : PopupViewAnimationSlideDelegate?
    public init( type : PopupAnimationSlideType ,_ origin : Origin? , _ delegate : PopupViewAnimationSlideDelegate?) {
        self.type = type
        self.origin = origin
        self.delegate = delegate
    }

   public func animationShow(popupView: UIView, overlayView: UIView, _ isLight : Bool?) {
        let sourceSize = overlayView.bounds.size
        let popupSize = popupView.bounds.size
        var popupStartRect : CGRect
        switch self.type {
        case.bottomBottom,.bottomTop:
            popupStartRect = CGRect(x: (sourceSize.width - popupSize.width)/2, y: sourceSize.height, width: popupSize.width, height: popupSize.height)
        case .leftRight,.leftLeft:
            popupStartRect = CGRect(x: -sourceSize.width, y: (sourceSize.height - popupSize.height)/2, width: popupSize.width, height: popupSize.height)
        case .topBottom,.topTop:
            popupStartRect = CGRect(x: (sourceSize.width - popupSize.width)/2, y: -popupSize.height, width: popupSize.width, height: popupSize.height)
        case .rightLeft,.rightRight:
            popupStartRect = CGRect(x: sourceSize.width, y: (sourceSize.height - popupSize.height)/2, width: popupSize.width, height: popupSize.height)
        }
        
        let popupEndRect = CGRect(x: self.origin?.x ?? (sourceSize.width - popupSize.width) / 2, y: self.origin?.y ?? (sourceSize.height - popupSize.height)/2 , width: popupSize.width, height: popupSize.height)
        
        popupView.frame = popupStartRect
        popupView.alpha = 1
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            if let _ = isLight {
                if isLight! {
                    overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0)
                }else{
                    overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
                }
            }else{
                overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
            }
            
            popupView.frame = popupEndRect
        }, completion: nil)
        
    }
    
   public func animationDismiss(popupView: UIView, overlayView: UIView, completion: @escaping (() -> Void)) {
        if let _ = self.delegate {
            if self.delegate!.responds(to: Selector.init(("popupViewWillDismiss"))) {
                self.delegate!.popupViewWillDismiss()
            }
        }
        
        let sourceSize = overlayView.bounds.size
        let popupSize = popupView.bounds.size
        
        var popupEndRect : CGRect
        switch self.type {
        case.topTop,.bottomTop:
            popupEndRect = CGRect(x: (sourceSize.width - popupSize.width)/2, y: -sourceSize.height, width: popupSize.width, height: popupSize.height)
        case .topBottom,.bottomBottom:
            popupEndRect = CGRect(x: (sourceSize.width - popupSize.width)/2, y: sourceSize.height, width: popupSize.width, height: popupSize.height)
        case .leftRight,.rightRight:
            popupEndRect = CGRect(x: sourceSize.width, y: popupView.frame.origin.y, width: popupSize.width, height: popupSize.height)
        case .leftLeft,.rightLeft:
            popupEndRect = CGRect(x: -popupSize.width, y: popupView.frame.origin.y, width: popupSize.width, height: popupSize.height)
        }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            popupView.frame = popupEndRect
            overlayView.popBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0)
        }, completion: { _ in
            popupView.alpha = 0
            completion()
        })
        
    }
    

}

public struct Origin {
    var x : CGFloat?
    var y : CGFloat?
    
    public init(x:CGFloat?, y:CGFloat?) {
        self.x = x
        self.y = y
    }
}
