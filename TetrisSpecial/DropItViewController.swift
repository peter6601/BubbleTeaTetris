//
//  DropItViewController.swift
//  TetrisSpecial
//
//  Created by 丁暐哲 on 2016/11/12.
//  Copyright © 2016年 Din. All rights reserved.
//

import UIKit

class DropItViewController: UIViewController
{
    @IBAction func clearView(_ sender: UIButton) {
//      playView.subviews.map({ $0.removeFromSuperview() })
        playView.subviews.forEach({ $0.removeFromSuperview()})
        playView.reloadInputViews()
        
     

    }

    @IBOutlet weak var playView: DropitView!{
        didSet{
            playView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addSomeDrop(recognizer:))))
            playView.addGestureRecognizer(UIPanGestureRecognizer(target: playView, action: #selector(DropitView.grabDrop(regonizer:))))
            playView.realGravity = switcher
        }
    }
    
    func addSomeDrop(recognizer: UITapGestureRecognizer){
        if recognizer.state == .ended{
            playView.addDrop()
        }
    }
// view life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playView.animating = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        playView.animating = true
        if bubbleTea {
            playView.backgroundColor = bubbleTeaColor
        }else{
            playView.backgroundColor = bubbleGreenTeaColor
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playView.animating = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        playView.animating = false
    }
    
}
