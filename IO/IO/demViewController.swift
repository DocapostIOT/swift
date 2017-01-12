//
//  demViewController.swift
//  IO
//
//  Created by Quentin Gras on 22/12/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit

class demViewController: UIViewController , UIScrollViewDelegate {
    
    
    @IBOutlet var suiv: UIButton!
    @IBOutlet var think: UIImageView!
    @IBOutlet var do1: UIImageView!
    @IBOutlet var launch: UIImageView!
    @IBOutlet var scroll: UIScrollView!
    var val = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.frame.size)
        scroll.delegate = self
        var im = UIImage(named: "page3");
        var image = UIImageView()
        image.image = im;
        image.frame = CGRect(x: 0, y: 0, width: CGFloat(4000), height:  CGFloat(700))
        image.sizeToFit()
        scroll.addSubview(image);
        scroll.contentSize.width = image.frame.size.width
        think.isUserInteractionEnabled = true;
        do1.isUserInteractionEnabled = true;
        launch.isUserInteractionEnabled = true;
        self.suiv.alpha = 0

        switch val{
        case 1:
            self.do1.image = #imageLiteral(resourceName: "thinkdolaunchblanc-2")
            break;
        case 2:
            self.launch.image = #imageLiteral(resourceName: "thinkdolaunchblanc-3")
            break;
        case 0:
            self.think.image = #imageLiteral(resourceName: "thinkdolaunchblanc-1")
            break;
        default:
            break;
        }
        
        self.scroll.contentOffset = CGPoint(x:val * Int(self.view.frame.size.width), y:0)
        
        let recognizer = UITapGestureRecognizer(target: self, action:#selector(think(_:)))
        think.addGestureRecognizer(recognizer)
        let recognizer2 = UITapGestureRecognizer(target: self, action:#selector(do1(_:)))
        do1.addGestureRecognizer(recognizer2)
        let recognizer3 = UITapGestureRecognizer(target: self, action:#selector(launch(_:)))
        launch.addGestureRecognizer(recognizer3)
 
        
        // self.view.addSubview(image);
        
    }
    
    func think(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*0, y:0)
        }, completion: nil)
        self.think.image = #imageLiteral(resourceName: "thinkdolaunchblanc-1")
        self.do1.image = #imageLiteral(resourceName: "Thinkdolaunch-2")
        self.launch.image = #imageLiteral(resourceName: "Thinkdolaunch-3")
        UIView.animate(withDuration: 0.4, animations: {
            self.suiv.alpha = 0
            
        }, completion: nil)
        
    }
    func do1(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*1, y:0)
        }, completion: nil)
        self.think.image = #imageLiteral(resourceName: "Thinkdolaunch-1")
        self.do1.image = #imageLiteral(resourceName: "thinkdolaunchblanc-2")
        self.launch.image = #imageLiteral(resourceName: "Thinkdolaunch-3")
        UIView.animate(withDuration: 0.4, animations: {
            self.suiv.alpha = 0
            
        }, completion: nil)
    }
    func launch(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*2, y:0)
        }, completion:  nil )
        self.think.image = #imageLiteral(resourceName: "Thinkdolaunch-1")
        self.do1.image = #imageLiteral(resourceName: "Thinkdolaunch-2")
        self.launch.image = #imageLiteral(resourceName: "thinkdolaunchblanc-3")
        UIView.animate(withDuration: 0.4, animations: {
            self.suiv.alpha = 1
            
        }, completion: nil)
    }
 
    
    var index = 0;
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print(scroll.contentOffset)
        
        var offset = scroll.contentOffset;
        offset.x -= 1.0;
        offset.y -= 1.0;
        scroll.setContentOffset(offset, animated: false)
        offset.x += 1.0;
        offset.y += 1.0;
        scroll.setContentOffset(offset, animated: false)
        var v = Int( ((scroll.contentOffset.x) / (self.view.frame.size.width)*10));
        
        print(v)
        print(index)
        if(index * 10 < v && v % 10 > 1){
            v += 10
        }
        if (index * 10 > v && v % 10 < 8){
            v -= v % 10
        }
        var v2 = Int(v/10);
        if (v2 >= 2){
            v2 = 2
        }
       
        index = Int(v2)
        
        
        
        var va = v2 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: { (finished) -> Void in
            switch v2{
            case 0:
                self.think.image = #imageLiteral(resourceName: "thinkdolaunchblanc-1")
                self.do1.image = #imageLiteral(resourceName: "Thinkdolaunch-2")
                self.launch.image = #imageLiteral(resourceName: "Thinkdolaunch-3")
                UIView.animate(withDuration: 0.4, animations: {
                    self.suiv.alpha = 0
                    
                }, completion: nil)
                break;
            case 1:
                self.think.image = #imageLiteral(resourceName: "Thinkdolaunch-1")
                self.do1.image = #imageLiteral(resourceName: "thinkdolaunchblanc-2")
                self.launch.image = #imageLiteral(resourceName: "Thinkdolaunch-3")
                UIView.animate(withDuration: 0.4, animations: {
                    self.suiv.alpha = 0
                    
                }, completion: nil)
                break;
            case 2:
                self.think.image = #imageLiteral(resourceName: "Thinkdolaunch-1")
                self.do1.image = #imageLiteral(resourceName: "Thinkdolaunch-2")
                self.launch.image = #imageLiteral(resourceName: "thinkdolaunchblanc-3")
                UIView.animate(withDuration: 0.4, animations: {
                    self.suiv.alpha = 1
                    
                }, completion: nil)
                break;

            default:
                break;
            }
        } )
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
