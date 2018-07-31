//
//  Results.swift
//  TU20 App
//
//  Created by Alexsia Louizos on 2018-07-29.
//  Copyright © 2018 Dean Louizos. All rights reserved.
//

import Foundation
import UIKit

class Results: UIViewController {
    var diagnosis = "1"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenH = self.view.frame.size.height
        let screenW = self.view.frame.size.width
        let ratioW: CGFloat = screenW/414
        let ratioH: CGFloat = screenW/700
        
        let background = UIView()
        background.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9764705882, blue: 0.9960784314, alpha: 1)
        background.frame.size = CGSize(width: screenW, height: screenH)
        background.center = self.view.center
        view.addSubview(background)
        
        let resultText = UILabel()
        resultText.frame.size = CGSize(width: screenW-80, height: 60)
        resultText.center = CGPoint(x: self.view.center.x, y: 75)
        resultText.text = "Results"
        resultText.font = UIFont(name: "Helvetica-Bold", size: 50)
        view.addSubview(resultText)
        
        let startOver = UIButton()
        startOver.frame.size = CGSize(width: screenW-60, height: 60)
        startOver.center = CGPoint(x: self.view.center.x, y: screenH-50)
        startOver.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.8862745098, blue: 0.9882352941, alpha: 1)
        startOver.setTitle("Start Over", for: .normal)
        startOver.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 35)
        startOver.layer.cornerRadius = 10
        startOver.addTarget(self, action: #selector(Results.startOverClicked), for: .touchUpInside)
        view.addSubview(startOver)
        
        
        let result = UILabel()
        result.frame.size = CGSize(width: screenW-80, height: 60)
        result.center = CGPoint(x: self.view.center.x, y: 150)
        result.font = UIFont(name: "Helvetica-Bold", size: 40)
        result.textAlignment = .center
        
        let line1 = UIView()
        line1.frame.size = CGSize(width: 300*ratioW, height: 16)
        line1.layer.cornerRadius = 8
        line1.center = CGPoint(x: screenW/2, y: 190)
        
        let line2 = UIView()
        line2.frame.size = CGSize(width: 175*ratioW, height: 16)
        line2.layer.cornerRadius = 8
        line2.center = CGPoint(x: screenW/2, y: 230)
        
        let text = UILabel()
        text.frame.size = CGSize(width: line1.frame.size.width+20, height: 200)
        text.center = CGPoint(x: screenW/2, y: 325)
        text.font = UIFont(name: "Helvetica", size: 20)
        text.textAlignment = .center
        
        if diagnosis == "free" {
            result.text = "BPPV Free"
            result.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            line1.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            line2.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            
            text.text = "The patient did not show signs of BPPV during the test."
            text.numberOfLines = 2
            text.frame.size.height = 225
            
        } else if diagnosis == "1" {
            result.text = "BPPV"
            result.textColor = #colorLiteral(red: 0.9000675082, green: 0, blue: 0, alpha: 1)
            line1.backgroundColor = #colorLiteral(red: 0.9000675082, green: 0, blue: 0, alpha: 1)
            line2.backgroundColor = #colorLiteral(red: 0.9000675082, green: 0, blue: 0, alpha: 1)
            
            text.text = "The patient showed signs of BPPV during the test which indicate a problem with the posterior semicircular canal."
            text.numberOfLines = 4
            text.frame.size.height = 250
            
        } else if diagnosis == "2" {
            result.text = "BPPV"
            result.textColor = #colorLiteral(red: 0.9000675082, green: 0, blue: 0, alpha: 1)
            line1.backgroundColor = #colorLiteral(red: 0.9000675082, green: 0, blue: 0, alpha: 1)
            line2.backgroundColor = #colorLiteral(red: 0.9000675082, green: 0, blue: 0, alpha: 1)
            
            text.text = "The patient showed signs of BPPV during the test which indicate a problem with the..."
            text.numberOfLines = 4
            
        } else if diagnosis == "3" {
            result.text = "BPPV"
            result.textColor = #colorLiteral(red: 0.9000675082, green: 0, blue: 0, alpha: 1)
            line1.backgroundColor = #colorLiteral(red: 0.9000675082, green: 0, blue: 0, alpha: 1)
            line2.backgroundColor = #colorLiteral(red: 0.9000675082, green: 0, blue: 0, alpha: 1)
            
            text.text = "The patient showed signs of BPPV during the test which indicate a problem with the..."
            text.numberOfLines = 4
            
        }
        
        view.addSubview(result)
        view.addSubview(line1)
        view.addSubview(line2)
        view.addSubview(text)
    }
    @objc func startOverClicked() {
        presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false)
    }
}
