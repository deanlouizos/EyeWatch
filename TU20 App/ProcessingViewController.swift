//
//  ProcessingViewController.swift
//  TU20 App
//
//  Created by Ansar Khan on 2018-07-18.
//  Copyright © 2018 Dean Louizos. All rights reserved.
//

import UIKit

class ProcessingViewController: UIViewController {
    var lines: [Line] = []
    var g = 0
    override func viewDidLoad() {
        let background = UIView(frame: self.view.frame)
        background.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9764705882, blue: 0.9960784314, alpha: 1)
        view.addSubview(background)
        
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ProcessingViewController.ani), userInfo: nil, repeats: true)
        
        let center = self.view.center
        let r1: CGFloat = 75
        
        let r2 = (self.view.frame.size.height/2)+100
        for n in 1...12 {
            let theta = CGFloat(2*n-1)*CGFloat.pi/12
            let alpha = CGFloat.pi-theta
            let b = r1/sin(theta)
            let beta = asin(CGFloat(b)*sin(alpha)/r2)
            let gamma = CGFloat.pi-alpha-beta
            
            let t = CGPoint(x: -r2*cos(gamma), y: r2*sin(gamma))
            
            lines.append(Line(angle: theta, length: 200, width: 6, focus: CGPoint(x: center.x+t.x, y: center.y+t.y), r2: self.view.frame.size.height+200))
            view.layer.addSublayer((lines[n-1].layer))
            lines[n-1].animate(duration: 3)
        }
        
        let processing = UILabel()
        processing.text = "Processing..."
        processing.frame.size = CGSize(width: 200, height: 50)
        processing.textAlignment = .center
        processing.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        processing.font = UIFont(name: "Helvetica-Bold", size: 25)
        processing.center = CGPoint(x: self.view.center.x, y: self.view.center.y+120)
        
        let back = UIView()
        back.frame.size = CGSize(width: 200, height: 50)
        back.center = processing.center
        back.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.8862745098, blue: 0.9882352941, alpha: 1)
        back.layer.cornerRadius = 10
        
        view.addSubview(back)
        view.addSubview(processing)
        
    }
    @objc func ani() {
        for n in 1...12 {
            lines[n-1].animate(duration: 3)
        }
        g += 1
        if g == 2 {
           present(Results(), animated: true)
            }
    }


}
