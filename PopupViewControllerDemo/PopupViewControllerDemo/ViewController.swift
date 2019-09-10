//
//  ViewController.swift
//  PopupViewControllerDemo
//
//  Created by 任敬 on 2019/9/9.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let popView = PopView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let bt = UIButton(frame: CGRect(x: 100, y: 200, width: 50, height: 50))
        bt.backgroundColor = UIColor.red
        self.view.addSubview(bt)
        bt.addTarget(self, action: #selector(showPop), for: .touchUpInside)
        
      
    }

    @objc func showPop() {
        popView.show(vc: self)
    }

}

