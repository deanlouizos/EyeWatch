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
    var camSelector = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenH = self.view.frame.size.height
        let screenW = self.view.frame.size.width
        let ratioW: CGFloat = screenW/414
        let ratioH = screenH/700
        
        let background = UIView()
        background.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9764705882, blue: 0.9960784314, alpha: 1)
        background.frame.size = CGSize(width: screenW, height: screenH)
        background.center = self.view.center
        view.addSubview(background)
        
        let back = UIButton()
        back.frame.size = CGSize(width: screenW-60, height: 60)
        back.center = CGPoint(x: self.view.center.x, y: screenH-50)
        back.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.8862745098, blue: 0.9882352941, alpha: 1)
        back.setTitle("Back", for: .normal)
        back.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 35)
        back.layer.cornerRadius = 10
        back.addTarget(self, action: #selector(Prep.backClicked), for: .touchUpInside)
        view.addSubview(back)
        
        let go = UIButton()
        go.frame.size = CGSize(width: screenW-60, height: 60)
        go.center = CGPoint(x: self.view.center.x, y: screenH-120)
        go.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.8862745098, blue: 0.9882352941, alpha: 1)
        go.setTitle("Go", for: .normal)
        go.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 35)
        go.layer.cornerRadius = 10
        go.addTarget(self, action: #selector(Prep.goClicked), for: .touchUpInside)
        view.addSubview(go)
       
        let timer = UILabel()
        timer.text = "Timer"
        timer.font = UIFont(name: "Helvetica-Bold", size: 35*ratioW)
        timer.frame.size = CGSize(width: 200*ratioW, height: 100)
        timer.center = CGPoint(x: 130*ratioW, y: 75*ratioH)
        timer.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(timer)
        
        let timerBack = UIView()
        timerBack.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.462745098, blue: 0.7098039216, alpha: 1)
        timerBack.frame.size = CGSize(width: screenW/4+10, height: screenW/4+10)
        timerBack.center = CGPoint(x: screenW/2, y: 155*ratioH)
        timerBack.layer.cornerRadius = screenW/8+5
        view.addSubview(timerBack)
        
        let timerBackground = UIView()
        timerBackground.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        timerBackground.frame.size = CGSize(width: screenW/4, height: screenW/4)
        timerBackground.center = CGPoint(x: screenW/2, y: 155*ratioH)
        timerBackground.layer.cornerRadius = screenW/8
        view.addSubview(timerBackground)
        
        timeSelector.maximumValue = 60
        timeSelector.minimumValue = 0
        timeSelector.frame.size.width = screenW-80
        timeSelector.center = CGPoint(x: screenW/2, y: 250*ratioH)
        timeSelector.minimumTrackTintColor = #colorLiteral(red: 0.1882352941, green: 0.462745098, blue: 0.7098039216, alpha: 1)
        timeSelector.addTarget(self, action: #selector(Prep.sliderChange), for: .valueChanged)
        view.addSubview(timeSelector)
        
        time.text = "5"
        time.frame.size = CGSize(width: 200, height: 200)
        time.center = CGPoint(x: screenW/2, y: 155*ratioH)
        time.font = UIFont(name: "Helvetica", size: 50*ratioW)
        time.textColor = #colorLiteral(red: 0.09411764706, green: 0.2470588235, blue: 0.4, alpha: 1)
        time.textAlignment = .center
        view.addSubview(time)
        
        let camSelect = UILabel()
        camSelect.text = "Camera Selection"
        camSelect.font = UIFont(name: "Helvetica-Bold", size: 35*ratioW)
        camSelect.frame.size = CGSize(width: 300*ratioW, height: 100)
        camSelect.center = CGPoint(x: 180*ratioW, y: 375*ratioH)
        camSelect.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(camSelect)
        
        camSelector.insertSegment(withTitle: "Front", at: 0, animated: false)
        camSelector.insertSegment(withTitle: "Rear", at: 1, animated: false)
        camSelector.frame.size = CGSize(width: 225*ratioW, height: 70*ratioH)
        camSelector.selectedSegmentIndex = 0
        camSelector.tintColor = #colorLiteral(red: 0.1882352941, green: 0.462745098, blue: 0.7098039216, alpha: 1)
        camSelector.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 25*ratioW)],
                                                            for: .normal)
        camSelector.center = CGPoint(x: screenW/2, y: 450*ratioH)
        view.addSubview(camSelector)
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
        present(RecordViewController(), animated: false)
    }
}
