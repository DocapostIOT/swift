//
//  Circle.swift
//  Colissimo
//
//  Created by Quentin Gras on 08/09/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit

class Circle: UIView {
    
    var color:UIColor
    var dest : CGRect!
    
    init(frame: CGRect, color: UIColor) {
        self.color = color
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        color.setFill()
        path.fill()
        
    }
    
}
