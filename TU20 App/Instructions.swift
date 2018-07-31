//
//  Instructions.swift
//  TU20 App
//
//  Created by Dean Louizos on 2018-07-16.
//  Copyright © 2018 Dean Louizos. All rights reserved.
//

import Foundation
import UIKit

class Instructions: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenW = self.view.frame.size.width
        let screenH = self.view.frame.size.height
        
        let background = UIView()
        background.frame.size = self.view.frame.size
        background.center = self.view.center
        background.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9764705882, blue: 0.9960784314, alpha: 1)
        view.addSubview(background)
        
        let back = UIButton()
        back.frame.size = CGSize(width: screenW-60, height: 60)
        back.center = CGPoint(x: self.view.center.x, y: screenH-50)
        back.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.8862745098, blue: 0.9882352941, alpha: 1)
        back.setTitle("Back", for: .normal)
        back.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 35)
        back.layer.cornerRadius = 10
        back.addTarget(self, action: #selector(Instructions.backClicked), for: .touchUpInside)
        view.addSubview(back)
    }
    @objc func backClicked() {
        dismiss(animated: true)
    }
}
