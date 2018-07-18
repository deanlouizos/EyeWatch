//
//  ProcessingViewController.swift
//  TU20 App
//
//  Created by Ansar Khan on 2018-07-18.
//  Copyright © 2018 Dean Louizos. All rights reserved.
//

import UIKit

class ProcessingViewController: UIViewController {
    
    override func viewDidLoad() {
        let screenH = self.view.frame.size.height
        let screenW = self.view.frame.size.width
        
        let background = UIView()
        background.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9764705882, blue: 0.9960784314, alpha: 1)
        background.frame.size = CGSize(width: screenW, height: screenH)
        background.center = self.view.center

        var lines: [Line] = []
        //var center = CGPoint(x: 207, y: 350)
        var center = self.view.center
        var r1: CGFloat = 75
        //var r2: CGFloat = 700
        var r2 = (self.view.frame.size.height/2)+20
         r1 /= 8
         r2 /= 8
        
        for n in 1...12 {
            
            var xo = center.x+r1*cos(CGFloat(2*n-1)*CGFloat.pi/12)
            var yo = center.y-r1*sin(CGFloat(2*n-1)*CGFloat.pi/12)
            
            let pi = CGFloat.pi;
            let theta = CGFloat(12+(2*n-1))*(pi/12.0)
            
            var x = r1*cos(theta)+(r1*r1*(1/tan(theta))*(1/tan(theta))-(1/sin(theta))*(1/sin(theta))*r1*r1+r2*r2).squareRoot()/(1/sin(theta))
            var y = -(r2*r2-x*x).squareRoot()
            
            x += self.view.frame.width/2
            y += self.view.frame.height/2
            
            lines.append(Line(angle: CGFloat(2*n-1)*(CGFloat.pi)/12, length: 500, width: 8, focus: CGPoint(x: x, y: y)))
            view.layer.addSublayer(lines[n-1].layer)
            lines[n-1].animate(duration: Double(n))
        }
        
    }
    


}
