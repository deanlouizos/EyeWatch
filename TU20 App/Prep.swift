//
//  prep.swift
//  TU20 App
//
//  Created by Dean Louizos on 2018-07-16.
//  Copyright © 2018 Dean Louizos. All rights reserved.
//

import Foundation
import UIKit

class Prep: UIViewController {
    var timeSelector = UISlider()
    var time = UILabel()
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
        timerBackground.frame.size = CGSize(width: screenW/2, height: 100)
        timerBackground.center = self.view.center
        view.addSubview(timerBackground)
        
        timeSelector.maximumValue = 60
        timeSelector.minimumValue = 0
        timeSelector.frame.size.width = screenW-80
        timeSelector.center = self.view.center
        timeSelector.minimumTrackTintColor = #colorLiteral(red: 0.1882352941, green: 0.462745098, blue: 0.7098039216, alpha: 1)
        timeSelector.addTarget(self, action: #selector(Prep.sliderChange), for: .valueChanged)
        view.addSubview(timeSelector)
        
        time.text = "\(Int(timeSelector.value))"
        time.frame.size = CGSize(width: 200, height: 200)
        time.center = CGPoint(x: 200, y: 200)
        time.font = UIFont(name: "Helvetica", size: 30)
        time.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        time.textAlignment = .center
        view.addSubview(time)
        
            
        
        
    }
    @objc func sliderChange() {
        if Int(timeSelector.value) <= 30 {
            time.text = "\((Int(timeSelector.value)/6)+5)"
        } else {
            time.text = "\((5*Int(timeSelector.value)/3)-40)"
        }
    }
    @objc func backClicked() {
        dismiss(animated: true)
        
    }
    @objc func goClicked() {
        let recordTime = Int(time.text!)
    }
}
//segmented control for front vs back
//slider for time
//switch for flash
