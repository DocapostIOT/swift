//
//  lastViewController.swift
//  IO
//
//  Created by Quentin Gras on 22/12/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit

class lastViewController: UIViewController , UIScrollViewDelegate {

    
    
    
    
    @IBAction func clic(_ sender: Any) {
        if (on){
            UIView.animate(withDuration: 0.4, animations: {
                self.p1.alpha = 0
                self.p2.alpha = 0
                self.p3.alpha = 0
                self.p4.alpha = 0
                self.p5.alpha = 0
                self.p6.alpha = 0
                self.p7.alpha = 0
                self.p8.alpha = 0
                self.p9.alpha = 0
                self.menu.alpha = 0
                self.but.setImage(#imageLiteral(resourceName: "menu_bouton"), for: .normal)
            }, completion: nil)
            on = false
        }
        else{
            UIView.animate(withDuration: 0.4, animations: {
                self.p1.alpha = 1
                self.p2.alpha = 1
                self.p3.alpha = 1
                self.p4.alpha = 1
                self.p5.alpha = 1
                self.p6.alpha = 1
                self.p7.alpha = 1
                self.p8.alpha = 1
                self.p9.alpha = 1
                self.menu.alpha = 1
                self.but.setImage(#imageLiteral(resourceName: "menu_bouton2"), for: .normal)
            }, completion: nil)
            on = true
        }
    }
    
    var on = false
    
    @IBOutlet var p9: UIImageView!
    @IBOutlet var p8: UIImageView!
    @IBOutlet var p7: UIImageView!
    @IBOutlet var p6: UIImageView!
    @IBOutlet var p1: UIImageView!
    @IBOutlet var p2: UIImageView!
    @IBOutlet var p3: UIImageView!
    @IBOutlet var p4: UIImageView!
    @IBOutlet var menu: UIImageView!
    @IBOutlet var p5: UIImageView!
    @IBOutlet var but: UIButton!
    @IBOutlet var scroll: UIScrollView!
    var val = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.frame.size)
        scroll.delegate = self
        
        var im = #imageLiteral(resourceName: "OKOK_slidelivrable.png")
        var image = UIImageView()
        image.image = im;
        image.frame = CGRect(x: 0, y: 0, width: CGFloat(4000), height:  CGFloat(700))
        image.sizeToFit()
        scroll.insertSubview(image, at: 0);
        scroll.contentSize.width = image.frame.size.width
        self.p1.alpha = 0
        self.p2.alpha = 0
        self.p3.alpha = 0
        self.p4.alpha = 0
        self.p5.alpha = 0
        self.p6.alpha = 0
        self.p7.alpha = 0
        self.p8.alpha = 0
        self.p9.alpha = 0
        self.menu.alpha = 0
        
        
        p1.isUserInteractionEnabled = true
        p2.isUserInteractionEnabled = true
        p3.isUserInteractionEnabled = true
        p4.isUserInteractionEnabled = true
        p5.isUserInteractionEnabled = true
        p6.isUserInteractionEnabled = true
        p7.isUserInteractionEnabled = true
        p8.isUserInteractionEnabled = true
        p9.isUserInteractionEnabled = true

        
        let recognizer = UITapGestureRecognizer(target: self, action:#selector(p1(_:)))
        p1.addGestureRecognizer(recognizer)
        let recognizer2 = UITapGestureRecognizer(target: self, action:#selector(p2(_:)))
        p2.addGestureRecognizer(recognizer2)
        let recognizer3 = UITapGestureRecognizer(target: self, action:#selector(p3(_:)))
        p3.addGestureRecognizer(recognizer3)
        let recognizer4 = UITapGestureRecognizer(target: self, action:#selector(p4(_:)))
        p4.addGestureRecognizer(recognizer4)
        let recognizer5 = UITapGestureRecognizer(target: self, action:#selector(p5(_:)))
        p5.addGestureRecognizer(recognizer5)
        let recognizer6 = UITapGestureRecognizer(target: self, action:#selector(p6(_:)))
        p6.addGestureRecognizer(recognizer6)
        let recognizer7 = UITapGestureRecognizer(target: self, action:#selector(p7(_:)))
        p7.addGestureRecognizer(recognizer7)
        let recognizer8 = UITapGestureRecognizer(target: self, action:#selector(p8(_:)))
        p8.addGestureRecognizer(recognizer8)
        let recognizer9 = UITapGestureRecognizer(target: self, action:#selector(p9(_:)))
        p9.addGestureRecognizer(recognizer9)
        
        
    }
    
    
    
    func p1(_ recognizer: UITapGestureRecognizer) {
        p1.image = #imageLiteral(resourceName: "projets-ok-1")
        p2.image = #imageLiteral(resourceName: "projets-2")
        p3.image = #imageLiteral(resourceName: "projets-3")
        p4.image = #imageLiteral(resourceName: "projets-4")
        p5.image = #imageLiteral(resourceName: "projets-5")
        p6.image = #imageLiteral(resourceName: "projets-6")
        p7.image = #imageLiteral(resourceName: "projets-7")
        p8.image = #imageLiteral(resourceName: "projets-8")
        p9.image = #imageLiteral(resourceName: "projets-9")
        var va = 0 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: nil)
        UIView.animate(withDuration: 0.4, animations: {
            self.p1.alpha = 0
            self.p2.alpha = 0
            self.p3.alpha = 0
            self.p4.alpha = 0
            self.p5.alpha = 0
            self.p6.alpha = 0
            self.p7.alpha = 0
            self.p8.alpha = 0
            self.p9.alpha = 0
            self.menu.alpha = 0
            self.but.setImage(#imageLiteral(resourceName: "menu_bouton"), for: .normal)
        }, completion: nil)
        on = false
    }
    
    func p2(_ recognizer: UITapGestureRecognizer) {
        p1.image = #imageLiteral(resourceName: "projets-1")
        p2.image = #imageLiteral(resourceName: "projets-ok-2")
        p3.image = #imageLiteral(resourceName: "projets-3")
        p4.image = #imageLiteral(resourceName: "projets-4")
        p5.image = #imageLiteral(resourceName: "projets-5")
        p6.image = #imageLiteral(resourceName: "projets-6")
        p7.image = #imageLiteral(resourceName: "projets-7")
        p8.image = #imageLiteral(resourceName: "projets-8")
        p9.image = #imageLiteral(resourceName: "projets-9")
        var va = 2 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: nil)
        UIView.animate(withDuration: 0.4, animations: {
            self.p1.alpha = 0
            self.p2.alpha = 0
            self.p3.alpha = 0
            self.p4.alpha = 0
            self.p5.alpha = 0
            self.p6.alpha = 0
            self.p7.alpha = 0
            self.p8.alpha = 0
            self.p9.alpha = 0
            self.menu.alpha = 0
            self.but.setImage(#imageLiteral(resourceName: "menu_bouton"), for: .normal)
        }, completion: nil)
        on = false
        
    }
    func p3(_ recognizer: UITapGestureRecognizer) {
        p1.image = #imageLiteral(resourceName: "projets-1")
        p2.image = #imageLiteral(resourceName: "projets-2")
        p3.image = #imageLiteral(resourceName: "projets-ok-3")
        p4.image = #imageLiteral(resourceName: "projets-4")
        p5.image = #imageLiteral(resourceName: "projets-5")
        p6.image = #imageLiteral(resourceName: "projets-6")
        p7.image = #imageLiteral(resourceName: "projets-7")
        p8.image = #imageLiteral(resourceName: "projets-8")
        p9.image = #imageLiteral(resourceName: "projets-9")
        var va = 3 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: nil)
    }
    func p4(_ recognizer: UITapGestureRecognizer) {
        p1.image = #imageLiteral(resourceName: "projets-1")
        p2.image = #imageLiteral(resourceName: "projets-2")
        p3.image = #imageLiteral(resourceName: "projets-3")
        p4.image = #imageLiteral(resourceName: "projets-ok-4")
        p5.image = #imageLiteral(resourceName: "projets-5")
        p6.image = #imageLiteral(resourceName: "projets-6")
        p7.image = #imageLiteral(resourceName: "projets-7")
        p8.image = #imageLiteral(resourceName: "projets-8")
        p9.image = #imageLiteral(resourceName: "projets-9")
        var va = 4 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: nil)
        UIView.animate(withDuration: 0.4, animations: {
            self.p1.alpha = 0
            self.p2.alpha = 0
            self.p3.alpha = 0
            self.p4.alpha = 0
            self.p5.alpha = 0
            self.p6.alpha = 0
            self.p7.alpha = 0
            self.p8.alpha = 0
            self.p9.alpha = 0
            self.menu.alpha = 0
            self.but.setImage(#imageLiteral(resourceName: "menu_bouton"), for: .normal)
        }, completion: nil)
        on = false
        
    }
    func p5(_ recognizer: UITapGestureRecognizer) {
        p1.image = #imageLiteral(resourceName: "projets-1")
        p2.image = #imageLiteral(resourceName: "projets-2")
        p3.image = #imageLiteral(resourceName: "projets-3")
        p4.image = #imageLiteral(resourceName: "projets-4")
        p5.image = #imageLiteral(resourceName: "projets-ok-5")
        p6.image = #imageLiteral(resourceName: "projets-6")
        p7.image = #imageLiteral(resourceName: "projets-7")
        p8.image = #imageLiteral(resourceName: "projets-8")
        p9.image = #imageLiteral(resourceName: "projets-9")
        var va = 5 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: nil)
        UIView.animate(withDuration: 0.4, animations: {
            self.p1.alpha = 0
            self.p2.alpha = 0
            self.p3.alpha = 0
            self.p4.alpha = 0
            self.p5.alpha = 0
            self.p6.alpha = 0
            self.p7.alpha = 0
            self.p8.alpha = 0
            self.p9.alpha = 0
            self.menu.alpha = 0
            self.but.setImage(#imageLiteral(resourceName: "menu_bouton"), for: .normal)
        }, completion: nil)
        on = false
        
    }
    func p6(_ recognizer: UITapGestureRecognizer) {
        p1.image = #imageLiteral(resourceName: "projets-1")
        p2.image = #imageLiteral(resourceName: "projets-2")
        p3.image = #imageLiteral(resourceName: "projets-3")
        p4.image = #imageLiteral(resourceName: "projets-4")
        p5.image = #imageLiteral(resourceName: "projets-5")
        p6.image = #imageLiteral(resourceName: "projets-ok-6")
        p7.image = #imageLiteral(resourceName: "projets-7")
        p8.image = #imageLiteral(resourceName: "projets-8")
        p9.image = #imageLiteral(resourceName: "projets-9")
        var va = 6 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: nil)
        UIView.animate(withDuration: 0.4, animations: {
            self.p1.alpha = 0
            self.p2.alpha = 0
            self.p3.alpha = 0
            self.p4.alpha = 0
            self.p5.alpha = 0
            self.p6.alpha = 0
            self.p7.alpha = 0
            self.p8.alpha = 0
            self.p9.alpha = 0
            self.menu.alpha = 0
            self.but.setImage(#imageLiteral(resourceName: "menu_bouton"), for: .normal)
        }, completion: nil)
        on = false
        
    }
    func p7(_ recognizer: UITapGestureRecognizer) {
        p1.image = #imageLiteral(resourceName: "projets-1")
        p2.image = #imageLiteral(resourceName: "projets-2")
        p3.image = #imageLiteral(resourceName: "projets-3")
        p4.image = #imageLiteral(resourceName: "projets-4")
        p5.image = #imageLiteral(resourceName: "projets-5")
        p6.image = #imageLiteral(resourceName: "projets-6")
        p7.image = #imageLiteral(resourceName: "projets-ok-7")
        p8.image = #imageLiteral(resourceName: "projets-8")
        p9.image = #imageLiteral(resourceName: "projets-9")
        var va = 7 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: nil)
        UIView.animate(withDuration: 0.4, animations: {
            self.p1.alpha = 0
            self.p2.alpha = 0
            self.p3.alpha = 0
            self.p4.alpha = 0
            self.p5.alpha = 0
            self.p6.alpha = 0
            self.p7.alpha = 0
            self.p8.alpha = 0
            self.p9.alpha = 0
            self.menu.alpha = 0
            self.but.setImage(#imageLiteral(resourceName: "menu_bouton"), for: .normal)
        }, completion: nil)
        on = false
        
    }
    func p8(_ recognizer: UITapGestureRecognizer) {
        
        p1.image = #imageLiteral(resourceName: "projets-1")
        p2.image = #imageLiteral(resourceName: "projets-2")
        p3.image = #imageLiteral(resourceName: "projets-3")
        p4.image = #imageLiteral(resourceName: "projets-4")
        p5.image = #imageLiteral(resourceName: "projets-5")
        p6.image = #imageLiteral(resourceName: "projets-6")
        p7.image = #imageLiteral(resourceName: "projets-7")
        p8.image = #imageLiteral(resourceName: "projets-ok-8")
        p9.image = #imageLiteral(resourceName: "projets-9")
        var va = 8 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: nil)
        UIView.animate(withDuration: 0.4, animations: {
            self.p1.alpha = 0
            self.p2.alpha = 0
            self.p3.alpha = 0
            self.p4.alpha = 0
            self.p5.alpha = 0
            self.p6.alpha = 0
            self.p7.alpha = 0
            self.p8.alpha = 0
            self.p9.alpha = 0
            self.menu.alpha = 0
            self.but.setImage(#imageLiteral(resourceName: "menu_bouton"), for: .normal)
        }, completion: nil)
        on = false
    }
    func p9(_ recognizer: UITapGestureRecognizer) {
        p1.image = #imageLiteral(resourceName: "projets-1")
        p2.image = #imageLiteral(resourceName: "projets-2")
        p3.image = #imageLiteral(resourceName: "projets-3")
        p4.image = #imageLiteral(resourceName: "projets-4")
        p5.image = #imageLiteral(resourceName: "projets-5")
        p6.image = #imageLiteral(resourceName: "projets-6")
        p7.image = #imageLiteral(resourceName: "projets-7")
        p8.image = #imageLiteral(resourceName: "projets-8")
        p9.image = #imageLiteral(resourceName: "projets-ok-9")
        var va = 9 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: nil)
        UIView.animate(withDuration: 0.4, animations: {
            self.p1.alpha = 0
            self.p2.alpha = 0
            self.p3.alpha = 0
            self.p4.alpha = 0
            self.p5.alpha = 0
            self.p6.alpha = 0
            self.p7.alpha = 0
            self.p8.alpha = 0
            self.p9.alpha = 0
            self.menu.alpha = 0
            self.but.setImage(#imageLiteral(resourceName: "menu_bouton"), for: .normal)
        }, completion: nil)
        on = false
    }
        /*
    @IBAction func clic(_ sender: Any) {
        if (on){
            UIView.animate(withDuration: 0.4, animations: {
            self.p1.alpha = 0
            self.p2.alpha = 0
            self.p3.alpha = 0
            self.p4.alpha = 0
            self.p5.alpha = 0
            self.p6.alpha = 0
            self.p7.alpha = 0
            self.p8.alpha = 0
            self.p9.alpha = 0
            self.menu.alpha = 0
            self.but.imageView?.image = #imageLiteral(resourceName: "menu_bouton")
            }, completion: nil)
        }
        else{
            UIView.animate(withDuration: 0.4, animations: {
                self.p1.alpha = 1
                self.p2.alpha = 1
                self.p3.alpha = 1
                self.p4.alpha = 1
                self.p5.alpha = 1
                self.p6.alpha = 1
                self.p7.alpha = 1
                self.p8.alpha = 1
                self.p9.alpha = 1
                self.menu.alpha = 1
                self.but.imageView?.image = #imageLiteral(resourceName: "menu_bouton2")
            }, completion: nil)
        }
    }
    
    var on = false
    
    @IBOutlet var p9: UIImageView!
    @IBOutlet var p8: UIImageView!
    @IBOutlet var p7: UIImageView!
    @IBOutlet var p6: UIImageView!
    @IBOutlet var p1: UIImageView!
    @IBOutlet var p2: UIImageView!
    @IBOutlet var p3: UIImageView!
    @IBOutlet var p4: UIImageView!
    @IBOutlet var menu: UIImageView!
    @IBOutlet var p5: UIImageView!
    @IBOutlet var but: UIButton!
    @IBOutlet var scroll: UIScrollView!
    var val = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.frame.size)
        scroll.delegate = self
        
        var im = #imageLiteral(resourceName: "Page.png")
        var image = UIImageView()
        image.image = im;
        image.frame = CGRect(x: 0, y: 0, width: CGFloat(4000), height:  CGFloat(700))
        image.sizeToFit()
        scroll.insertSubview(image, at: 0);
        scroll.contentSize.width = image.frame.size.width
        // menu.image = #imageLiteral(resourceName: "menu")
        but.imageView?.image = #imageLiteral(resourceName: "menu_bouton")
        p1.image = #imageLiteral(resourceName: "projets-1")
        p2.image = #imageLiteral(resourceName: "projets-2")
        p3.image = #imageLiteral(resourceName: "projets-3")
        p4.image = #imageLiteral(resourceName: "projets-4")
        p5.image = #imageLiteral(resourceName: "projets-5")
        p6.image = #imageLiteral(resourceName: "projets-6")
        p7.image = #imageLiteral(resourceName: "projets-7")
        p8.image = #imageLiteral(resourceName: "projets-8")
        p9.image = #imageLiteral(resourceName: "projets-9")
        
    }*/

    
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
        if (v2 > 9){
            v2 = 9
        }
        index = Int(v2)
        
        
        
        var va = v2 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
