//
//  DropitView.swift
//  TetrisSpecial
//
//  Created by 丁暐哲 on 2016/11/12.
//  Copyright © 2016年 Din. All rights reserved.
//

import UIKit
import CoreMotion

class DropitView: NamedBezierPathsView, UIDynamicAnimatorDelegate
{
    private lazy var animator: UIDynamicAnimator = {
      let animator =   UIDynamicAnimator(referenceView: self)
        //告訴delegate 
        animator.delegate = self
        return animator
    }()
    
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
   //寫太多次加與移除item，太重復，另外開支檔案集中處理
    private let dropBehavior = FallingObjectBechavior()
    
    var animating: Bool = false {
        didSet {
            if animating {
//新方法，寫一起
             animator.addBehavior(dropBehavior)
            updateRealGravity()
//舊方法，重複寫
//                animator.addBehavior(gravity)
//                animator.addBehavior(collider)
            }else{
                animator.removeBehavior(dropBehavior)
//                animator.removeBehavior(gravity)
//                animator.removeBehavior(collider)
            }
        }
    }
    
    
    var realGravity: Bool = false {
        didSet {
            updateRealGravity()
        }
    }
    //加上Gryo，虛實機測試
    private let motionManger = CMMotionManager()
    private func updateRealGravity(){
        if realGravity {
          //確定可用但還沒被啟用
            if motionManger.isAccelerometerAvailable && !motionManger.isAccelerometerActive {
                motionManger.accelerometerUpdateInterval = 0.1
                motionManger.startAccelerometerUpdates(to: OperationQueue.main)
                { [unowned self] (data, error) in
                    if self .dropBehavior.dynamicAnimator != nil {
                        if var dx = data?.acceleration.x, var dy = data?.acceleration.y {
                            switch UIDevice.current.orientation {
                            case .portrait: dy = -dy
                            case .portraitUpsideDown: break
                            case .landscapeRight: swap(&dx, &dy)
                            case .landscapeLeft: swap(&dx, &dy); dy = -dy
                            default: dx = 0; dy = 0;
                            }
                            
                            
                            
                            self.dropBehavior.gravity.gravityDirection = CGVector(dx: dx, dy: dy)
                        } else{
                            self.motionManger.stopAccelerometerUpdates()
                        }

                    }
                                   }
            }
        }else{
            motionManger.stopAccelerometerUpdates()
        }
        
    }
    
    //把pan的線顯示出來加上去
    private var attachment: UIAttachmentBehavior? {
        willSet{
            if attachment != nil{
                animator.removeBehavior(attachment!)
            }
        }
        didSet {
            if attachment != nil {
                animator.addBehavior(attachment!)
                //能看得到手勢移動路徑
                attachment!.action = {
                    if let attachedDrop = self.attachment!.items.first as? UIView {
//                        self.bezierPaths[PathNames.Attchment] = UIBezierPath.lineForm(from: self.attachment!.anchorPoint, to: attachedDrop.center)
                    }
                }
            }
        }
    }
    
    
    private struct PathNames {
        static let MiddleBarrier = "MiddleBarrier"
        static let Attchment = "Attachment"
    }
    
    //把障礙加在middle上
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(ovalIn: CGRect(center: bounds.mid, size: dropSize))
        dropBehavior.addBarrier(path: path, name: PathNames.MiddleBarrier)
        //讓障礙看得見
//        bezierPaths[PathNames.MiddleBarrier] = path
    }
    
    //抓最後一個方塊
    func grabDrop(regonizer: UIPanGestureRecognizer) {
        let gesturePoint = regonizer.location(in: self)
        switch regonizer.state {
        case .began:
            //create the attachement
            if let dropToAttachTo = lastDrop, dropToAttachTo.superview != nil {
                attachment = UIAttachmentBehavior(item: dropToAttachTo, attachedToAnchor: gesturePoint)
            }
            lastDrop = nil
        case .changed:
            //change the attachement's anchor point
            attachment?.anchorPoint = gesturePoint
        default:
            attachment = nil
        }
    }
    
    //當完成一條時，要消除
    private func removeCompletedRow()
    {
        var dropToRemove = [UIView]()
        var hitTestRect = CGRect(origin: bounds.lowerLeft, size: dropSize)
        repeat
        {
            hitTestRect.origin.x = bounds.minX
            hitTestRect.origin.y -= dropSize.height
            var dropsTested = 0
            var dropsFound = [UIView]()
            while dropsTested < dropsPerRow {
                if let hitView = hitTest(p: hitTestRect.mid), hitView.superview == self {
                    dropsFound.append(hitView)
                }else{
                    break
                }
                hitTestRect.origin.x += dropSize.width
                dropsTested += 1
            }
            if dropsTested == dropsPerRow{
                dropToRemove += dropsFound
            }
            
        }while dropToRemove.count == 0 && hitTestRect.origin.y > bounds.minY
        for drop in dropToRemove {
            dropBehavior.removeItem(item: drop)
            drop.removeFromSuperview()
        }
    }
    
    //基本設定
    
    private let dropsPerRow = partical
    private var dropSize:CGSize {
        let size = bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    
    }
    
    private var lastDrop: UIView?
    
   func addDrop()
   {
  var frame = CGRect(origin: CGPoint.zero, size: dropSize)
    frame.origin.x = CGFloat.random(max: dropsPerRow) * dropSize.width
     let drop:UIView! = UIView(frame: frame)
    
    if !GrassJelly {
        drop.layer.cornerRadius = dropSize.width / 2

    }
    
    drop.backgroundColor = UIColor.random
    addSubview(drop)
    
    
    // 新方法，寫一起
    dropBehavior.addItem(item: drop)
    
// 舊方法一個一個寫
//    gravity.addItem(drop)
//    collider.addItem(drop)
    
    lastDrop = drop
    
    }

}
