//
//  UIkitExtension.swift
//  TetrisSpecial
//
//  Created by 丁暐哲 on 2016/11/12.
//  Copyright © 2016年 Din. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    static func random(max:Int) ->CGFloat {
        return CGFloat(arc4random() % UInt32(max) )
    }
}

extension UIColor {
    class var random: UIColor {
        switch arc4random()%5 {
//        case 0: return UIColor.green
//        case 1: return UIColor.blue
//        case 2: return UIColor.yellow
//        case 3: return UIColor.red
//        case 4: return UIColor.gray
        case 0...2: return UIColor.black
        case 3...4: return UIColor.white
            
        default: return UIColor.orange
        }
    }
}
extension CGRect {
    var mid: CGPoint{ return CGPoint(x: midX, y: midY)}
    var upperLeft: CGPoint{return CGPoint(x: minX, y: minY)}
    var lowerLeft: CGPoint{return CGPoint(x: minX, y: maxY)}
    var upperRight: CGPoint{return CGPoint(x: maxX, y: minY)}
    var lowerRight: CGPoint{return CGPoint(x: maxX, y: maxY)}
    
    init(center: CGPoint, size: CGSize) {
        let upperLeft = CGPoint(x: center.x - size.width/2, y: center.y - size.height/2)
        self.init(origin: upperLeft, size: size)
    }
}

extension UIView {
    func hitTest(p: CGPoint) -> UIView? {
        return hitTest(p, with: nil)
    }
}

extension UIBezierPath {
    class func lineForm(from: CGPoint, to: CGPoint) -> UIBezierPath{
            let path = UIBezierPath()
            path.move(to: from)
            path.addLine(to: to)
            return path
    }
}
