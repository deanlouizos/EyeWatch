import Foundation
import UIKit

class Line {
    var path1 = UIBezierPath()
    var path2 = UIBezierPath()
    var layer = CAShapeLayer()
    
    init(angle: CGFloat, length: CGFloat, width: CGFloat, focus: CGPoint) {
        var fi = (CGFloat.pi/2)-angle
        var u = CGPoint(x: (width/2)*cos(fi), y: (width/2)*sin(fi))
        var v = CGPoint(x: length*cos(angle), y: -length*sin(angle))
        var diameter: CGFloat = 500+20
        var d = CGPoint(x: diameter*cos(angle), y: -diameter*sin(angle))
        path1.move(to: CGPoint(x: focus.x+u.x, y: focus.y+u.y))
        path1.addLine(to: CGPoint(x: focus.x-u.x, y: focus.y-u.y))
        path1.addLine(to: CGPoint(x: focus.x-u.x+v.x, y: focus.y-u.y+v.y))
        path1.addLine(to: CGPoint(x: focus.x+u.x+v.x, y: focus.y+u.y+v.y))
        path1.close()
        
        path2.move(to: CGPoint(x: focus.x+u.x+d.x, y: focus.y+u.y+d.y))
        path2.addLine(to: CGPoint(x: focus.x-u.x+d.x, y: focus.y-u.y+d.y))
        path2.addLine(to: CGPoint(x: focus.x-u.x+v.x+d.x, y: focus.y-u.y+v.y+d.y))
        path2.addLine(to: CGPoint(x: focus.x+u.x+v.x+d.x, y: focus.y+u.y+v.y+d.y))
        path2.close()
        
        layer.path = path1.cgPath
        layer.fillColor = #colorLiteral(red: 0.176470592617989, green: 0.498039215803146, blue: 0.756862759590149, alpha: 1.0)
    }
    func animate(duration: Double) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = path1
        animation.toValue = path2
        animation.duration = duration
        
        layer.add(animation, forKey: "path")
    }
}
