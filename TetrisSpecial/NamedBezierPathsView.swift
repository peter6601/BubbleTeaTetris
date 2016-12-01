//
//  NamedBezierPathsView.swift
//  TetrisSpecial
//
//  Created by 丁暐哲 on 2016/11/13.
//  Copyright © 2016年 Din. All rights reserved.
//

import UIKit
//繪製障礙的路徑
class NamedBezierPathsView: UIView {

    var bezierPaths = [String: UIBezierPath]() {didSet{setNeedsDisplay() } }

    override func draw(_ rect: CGRect) {
        for(_,path) in bezierPaths {
            path.stroke()
        }
    }
   

}
