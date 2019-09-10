//
//  PopView.swift
//  PopupViewControllerDemo
//
//  Created by 任敬 on 2019/9/9.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit
import PopupViewController


class PopView: UIView {

    var vc : UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bindViewModel()
        self.setupViews()
        self.addAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension PopView {
    func show(vc : UIViewController) {
        self.vc = vc
//         let animation = PopupViewAnimationFade(CGPoint(x: 300, y: 200))
//        let animation  = PopupViewAnimationDrop()

        
        let animation = PopupViewAnimationSlide(type: .topTop, Origin(x:nil,y:100), nil)
//        let animation = PopupViewAnimationSpring()
        
        vc.presentPopupView(popupView: self, animation: animation, backgroundClickable: true, isLight: true , dismiss: {
            print("dismiss")
        })
    }
    
    func hide(){
        if let _ = self.vc{
            self.vc!.dismissPopupView()
        }
    }
}

extension PopView {
    
    private func setupViews() {
        self.bounds = CGRect(x: 0, y: 0, width: 300, height: 200)
        self.backgroundColor = UIColor.blue
    }
    
    private func addAction() {
        
    }
    
    private func bindViewModel() {
        
    }
}
