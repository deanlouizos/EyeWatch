//
//  Line.swift
//  Animation trial
//
//  Created by Dean Louizos on 2018-07-16.
//  Copyright © 2018 Dean Louizos. All rights reserved.
//

import Foundation
import UIKit

class Line {
    var path1 = UIBezierPath()
    var path2 = UIBezierPath()
    var layer = CAShapeLayer()
    var n = 0
    var anims: [CABasicAnimation] = []
    init(angle: CGFloat, length: CGFloat, width: CGFloat, focus: CGPoint, r2: CGFloat) {
        let fi = (CGFloat.pi/2)-angle
        let u = CGPoint(x: (width/2)*cos(fi), y: (width/2)*sin(fi))
        let v = CGPoint(x: length*cos(angle), y: -length*sin(angle))
        let s = CGPoint(x: r2*cos(angle), y: r2*sin(angle))
        path1.move(to: CGPoint(x: focus.x+u.x-v.x-20*cos(angle), y: focus.y+u.y-v.y+20*sin(angle)))
        path1.addLine(to: CGPoint(x: focus.x-u.x-v.x-20*cos(angle), y: focus.y-u.y-v.y+20*sin(angle)))
        path1.addLine(to: CGPoint(x: focus.x-u.x-20*cos(angle), y: focus.y-u.y+20*sin(angle)))
        path1.addLine(to: CGPoint(x: focus.x+u.x-20*cos(angle), y: focus.y+u.y+20*sin(angle)))
        path1.close()
        
        path2.move(to: CGPoint(x: focus.x+u.x+s.x, y: focus.y+u.y-s.y))
        path2.addLine(to: CGPoint(x: focus.x-u.x+s.x, y: focus.y-u.y-s.y))
        path2.addLine(to: CGPoint(x: focus.x-u.x+v.x+s.x, y: focus.y-u.y+v.y-s.y))
        path2.addLine(to: CGPoint(x: focus.x+u.x+v.x+s.x, y: focus.y+u.y+v.y-s.y))
        path2.close()
        
        layer.path = path1.cgPath
        layer.fillColor = #colorLiteral(red: 0.176470592617989, green: 0.498039215803146, blue: 0.756862759590149, alpha: 1.0)
    }
    func animate(duration: Double) {
        anims.append(CABasicAnimation(keyPath: "path"))
        anims[0].fromValue = path1.cgPath
        anims[0].toValue = path2.cgPath
        anims[0].duration = duration
        
        layer.add(anims[0], forKey: "path")
        anims.remove(at: 0)
        
    }
}
