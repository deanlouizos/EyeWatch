//
//  prep.swift
//  TU20 App
//
//  Created by Alexsia Louizos on 2018-07-16.
//  Copyright © 2018 Dean Louizos. All rights reserved.
//

import Foundation
import UIKit

class Prep: UIViewController {
    var timer = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenH = self.view.frame.size.height
        let screenW = self.view.frame.size.width
        
        let background = UIView()
        background.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9764705882, blue: 0.9960784314, alpha: 1)
        background.frame.size = CGSize(width: screenW, height: screenH)
        background.center = self.view.center
        view.addSubview(background)
        
        let back = UIButton()
        back.frame.size = CGSize(width: screenW-80, height: 60)
        back.center = CGPoint(x: self.view.center.x, y: screenH-50)
        back.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.8862745098, blue: 0.9882352941, alpha: 1)
        back.setTitle("Back", for: .normal)
        back.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 35)
        back.addTarget(self, action: #selector(Prep.backClicked), for: .touchUpInside)
        view.addSubview(back)
        
        let go = UIButton()
        go.frame.size = CGSize(width: screenW-80, height: 60)
        go.center = CGPoint(x: self.view.center.x, y: screenH-120)
        go.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.8862745098, blue: 0.9882352941, alpha: 1)
        go.setTitle("Go", for: .normal)
        go.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 35)
        go.addTarget(self, action: #selector(Prep.goClicked), for: .touchUpInside)
        view.addSubview(go)
        
        let timerBackground = UIView()
        timerBackground.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        timerBackground.frame.size = CGSize(width: screenW-170, height: 100)
        timerBackground.center = self.view.center
        view.addSubview(timerBackground)
        
        self.timer.keyboardType = UIKeyboardType.numberPad
        self.timer.frame.size = CGSize(width: screenW-200, height: 100)
        self.timer.center = timerBackground.center
        self.timer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.timer.font = UIFont(name: "Helvetica-Bold", size: 60)
        self.timer.textAlignment = .center
        view.addSubview(self.timer)
    }
    @objc func backClicked() {
        dismiss(animated: true)
    }
    @objc func goClicked() {
        if Int(self.timer.text!)! > 60 {
            let error = UILabel()
            error.text = "The entered number is too large. The timer cannot exceed 60 seconds."
            error.frame.size = CGSize(width: self.view.frame.size.width-60, height: 80)
            error.font = UIFont(name: "Helvetica-Bold", size: 20)
            error.textAlignment = .center
            error.center = CGPoint(x: self.view.center.x, y: self.view.center.y+90)
            error.textColor = #colorLiteral(red: 0.9029565454, green: 0, blue: 0, alpha: 1)
            error.numberOfLines = 2
            view.addSubview(error)
        } else {
            present(RecordViewController(), animated: true)
        }
    }
}
//segmented control for front vs back
// slider for time
//switch for flash
