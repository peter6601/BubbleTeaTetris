//
//  FallingObjectBechavior.swift
//  TetrisSpecial
//
//  Created by 丁暐哲 on 2016/11/12.
//  Copyright © 2016年 Din. All rights reserved.
//

import UIKit

class FallingObjectBechavior: UIDynamicBehavior
{
    private let collider: UICollisionBehavior = {
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        return collider
    }()
 let gravity = UIGravityBehavior()
    
    //讓物體的屬性設定不轉跟彈性係數
    private let itemBehavior: UIDynamicItemBehavior = {
        let dib = UIDynamicItemBehavior()
        dib.allowsRotation = true
        dib.elasticity = 0.5
        return dib
    }()
    
    func addBarrier(path: UIBezierPath, name: String){
        collider.removeBoundary(withIdentifier: name as NSCopying)
        collider.addBoundary(withIdentifier: name as NSCopying, for: path)
    }
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(itemBehavior)
    }
    
    func addItem (item: UIDynamicItem) {
        gravity.addItem(item)
        collider.addItem(item)
        itemBehavior.addItem(item)
    }
    
    func removeItem(item: UIDynamicItem){
        gravity.removeItem(item)
        collider.removeItem(item)
        itemBehavior.removeItem(item)
    }
}
