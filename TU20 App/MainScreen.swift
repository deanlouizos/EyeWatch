//
//  ViewController.swift
//  TU20 App
//
//  Created by Alexsia Louizos on 2018-07-15.
//  Copyright © 2018 Dean Louizos. All rights reserved.
//

import UIKit

class MainScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenH = self.view.frame.size.height
        let screenW = self.view.frame.size.width
        
        let background = UIView()
        background.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9764705882, blue: 0.9960784314, alpha: 1)
        background.frame.size = CGSize(width: screenW, height: screenH)
        background.center = self.view.center
        view.addSubview(background)
        
        let eye = Eye(radius: screenW/2, center: CGPoint(x: self.view.center.x, y: screenH))
        
        let title = UILabel()
        title.text = "Eye Watch"
        title.numberOfLines = 2
        title.font = UIFont(name: "Helvetica-Bold", size: 80)
        title.textAlignment = .center
        title.frame.size = CGSize(width: screenW-80, height: 200)
        title.center = CGPoint(x: screenW/2, y: 150)
        view.addSubview(title)
        
        let start = UIButton()
        start.frame.size = CGSize(width: screenW-80, height: 60)
        start.center = CGPoint(x: self.view.center.x, y: self.view.center.y-20)
        start.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.8862745098, blue: 0.9882352941, alpha: 1)
        start.setTitle("Start", for: .normal)
        start.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 35)
        start.addTarget(self, action: #selector(MainScreen.startClicked), for: .touchUpInside)
        view.addSubview(start)
        
        let howTo = UIButton()
        howTo.frame.size = CGSize(width: screenW-80, height: 60)
        howTo.center = CGPoint(x: self.view.center.x, y: self.view.center.y+60)
        howTo.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.8862745098, blue: 0.9882352941, alpha: 1)
        howTo.setTitle("How to Use", for: .normal)
        howTo.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 35)
        howTo.addTarget(self, action: #selector(MainScreen.howToClicked), for: .touchUpInside)
        view.addSubview(howTo)
        
        view.layer.addSublayer(eye.irisLayer)
        view.layer.addSublayer(eye.circleLayer)
        view.layer.addSublayer(eye.starLayer)
        view.layer.addSublayer(eye.pupilLayer)
    }
    @objc func startClicked() {
        present(Prep(), animated: true)
    }
    @objc func howToClicked() {
        present(UIViewController(), animated: true)
    }

}

