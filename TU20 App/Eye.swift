//
//  Eye.swift
//  TU20 App
//
//  Created by Dean Louizos on 2018-07-16.
//  Copyright © 2018 Dean Louizos. All rights reserved.
//

import Foundation
import UIKit

class Eye {
    
    var irisLayer = CAShapeLayer()
    var circleLayer = CAShapeLayer()
    var starLayer = CAShapeLayer()
    var pupilLayer = CAShapeLayer()
    
    init(radius: CGFloat, center: CGPoint) {
        let irisPath = UIBezierPath()
        let irisLayer = CAShapeLayer()
        let circlePath = UIBezierPath()
        let circleLayer = CAShapeLayer()
        let starPath = UIBezierPath()
        let starLayer = CAShapeLayer()
        let pupilPath = UIBezierPath()
        let pupilLayer = CAShapeLayer()
        
        //Iris path created
        irisPath.move(to: CGPoint(x: center.x+radius, y: center.y))
        irisPath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: false)
        irisPath.close()
        
        irisLayer.path = irisPath.cgPath
        irisLayer.fillColor = #colorLiteral(red: 0.1882352941, green: 0.462745098, blue: 0.7058823529, alpha: 1)
        
        
        
        //Circle path created
        circlePath.move(to: CGPoint(x: center.x, y: center.y+radius))
        circlePath.addArc(withCenter: center, radius: 3*radius/4, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(3*Double.pi/4), clockwise: false)
        circlePath.close()
        circleLayer.lineWidth = 5
        circleLayer.strokeColor = #colorLiteral(red: 0.4, green: 0.7294117647, blue: 0.9607843137, alpha: 1)

        //fix connection types
        circleLayer.fillColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0)
        circleLayer.path = circlePath.cgPath
        
        
            //Star path created
        starPath.move(to: CGPoint(x: center.x+radius, y: center.y))
        var xi: CGFloat = 0.0
        var yi: CGFloat = 0.0
        var xo: CGFloat = 0.0
        var yo: CGFloat = 0.0
        for n in 1...10 {
            xo = radius*CGFloat(cos(Double(n)*Double.pi/10))
            yo = (radius*radius-xo*xo).squareRoot()
            xi = (radius/3)*CGFloat(cos((Double(n)-0.5)*Double.pi/10))
            yi = ((radius*radius/9)-xi*xi).squareRoot()
            starPath.addLine(to: CGPoint(x: center.x+xi, y: center.y-yi))
            starPath.addLine(to: CGPoint(x: center.x+xo, y: center.y-yo))
        }
        starPath.close()
        starLayer.fillColor = #colorLiteral(red: 0.1137254902, green: 0.3019607843, blue: 0.4862745098, alpha: 1)
        starLayer.path = starPath.cgPath
            
        //Pupil path created
        pupilPath.move(to: CGPoint(x: center.x+radius/3, y: center.y))
        pupilPath.addArc(withCenter: center, radius: radius/3, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: false)
        pupilPath.close()
        pupilLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pupilLayer.path = pupilPath.cgPath
        self.irisLayer = irisLayer
        self.circleLayer = circleLayer
        self.starLayer = starLayer
        self.pupilLayer = pupilLayer
    }
}

