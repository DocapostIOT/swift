//
//  nav2ViewController.swift
//  IO
//
//  Created by Quentin Gras on 20/12/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit

class nav2ViewController: UIViewController, UIScrollViewDelegate {

   
    @IBOutlet var suiv: UIButton!
    @IBOutlet var ana: UIImageView!
    @IBOutlet var make: UIImageView!
    @IBOutlet var desi: UIImageView!
    @IBOutlet var crea: UIImageView!
    @IBOutlet var scroll: UIScrollView!
    var val = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.frame.size)
        scroll.delegate = self
        var im = UIImage(named: "page1");
        var image = UIImageView()
        image.image = im;
        image.frame = CGRect(x: 0, y: 0, width: CGFloat(4000), height:  CGFloat(700))
        image.sizeToFit()
        scroll.addSubview(image);
        scroll.contentSize.width = image.frame.size.width
        ana.isUserInteractionEnabled = true;
        make.isUserInteractionEnabled = true;
        crea.isUserInteractionEnabled = true;
        desi.isUserInteractionEnabled = true;
        self.suiv.alpha = 0

        switch val{
        case 1:
            self.crea.image = #imageLiteral(resourceName: "lescréatifs-2")
            break;
        case 2:
            self.desi.image = #imageLiteral(resourceName: "lesdesigners-2")
            break;
        case 3:
            self.make.image = #imageLiteral(resourceName: "lesmakers-2")
            break;
        case 0:
            self.ana.image = #imageLiteral(resourceName: "lesanalystes-2")
            break;
        default:
            break;
        }

        self.scroll.contentOffset = CGPoint(x:val * Int(self.view.frame.size.width), y:0)
        
        let recognizer = UITapGestureRecognizer(target: self, action:#selector(ana(_:)))
        ana.addGestureRecognizer(recognizer)
        let recognizer2 = UITapGestureRecognizer(target: self, action:#selector(make(_:)))
        make.addGestureRecognizer(recognizer2)
        let recognizer3 = UITapGestureRecognizer(target: self, action:#selector(crea(_:)))
        crea.addGestureRecognizer(recognizer3)
        let recognizer4 = UITapGestureRecognizer(target: self, action:#selector(desi(_:)))
        desi.addGestureRecognizer(recognizer4)
      
        // self.view.addSubview(image);
        
    }
    
    func crea(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*1, y:0)
        }, completion: nil)
        self.ana.image = #imageLiteral(resourceName: "lesanalystes-1")
        self.crea.image = #imageLiteral(resourceName: "lescréatifs-2")
        self.make.image = #imageLiteral(resourceName: "lesmakers-1")
        self.desi.image = #imageLiteral(resourceName: "lesdesigners-1")
        UIView.animate(withDuration: 0.4, animations: {
            self.suiv.alpha = 0
            
        }, completion: nil)
    }
    func desi(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*2, y:0)
        }, completion: nil)
        self.ana.image = #imageLiteral(resourceName: "lesanalystes-1")
        self.crea.image = #imageLiteral(resourceName: "lescréatifs-1")
        self.make.image = #imageLiteral(resourceName: "lesmakers-1")
        self.desi.image = #imageLiteral(resourceName: "lesdesigners-2")
        UIView.animate(withDuration: 0.4, animations: {
            self.suiv.alpha = 0
            
        }, completion: nil)
        
    }
    func make(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*3, y:0)
        }, completion:  nil )
        self.ana.image = #imageLiteral(resourceName: "lesanalystes-1")
        self.crea.image = #imageLiteral(resourceName: "lescréatifs-1")
        self.make.image = #imageLiteral(resourceName: "lesmakers-2")
        self.desi.image = #imageLiteral(resourceName: "lesdesigners-1")
        UIView.animate(withDuration: 0.4, animations: {
            self.suiv.alpha = 1
            
        }, completion: nil)
    }
    func ana(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*0, y:0)
        }, completion: nil)
        self.ana.image = #imageLiteral(resourceName: "lesanalystes-2")
        self.crea.image = #imageLiteral(resourceName: "lescréatifs-1")
        self.make.image = #imageLiteral(resourceName: "lesmakers-1")
        self.desi.image = #imageLiteral(resourceName: "lesdesigners-1")
        UIView.animate(withDuration: 0.4, animations: {
            self.suiv.alpha = 0
            
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
        if (v2 >= 3){
            v2 = 3
        }
      
        index = Int(v2)
        
        
        
        var va = v2 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion: { (finished) -> Void in
            switch v2{
            case 0:
                self.ana.image = #imageLiteral(resourceName: "lesanalystes-2")
                self.crea.image = #imageLiteral(resourceName: "lescréatifs-1")
                self.make.image = #imageLiteral(resourceName: "lesmakers-1")
                self.desi.image = #imageLiteral(resourceName: "lesdesigners-1")
                UIView.animate(withDuration: 0.4, animations: {
                    self.suiv.alpha = 0
                    
                }, completion: nil)
                break;
            case 1:
                self.ana.image = #imageLiteral(resourceName: "lesanalystes-1")
                self.crea.image = #imageLiteral(resourceName: "lescréatifs-2")
                self.make.image = #imageLiteral(resourceName: "lesmakers-1")
                self.desi.image = #imageLiteral(resourceName: "lesdesigners-1")
                UIView.animate(withDuration: 0.4, animations: {
                    self.suiv.alpha = 0
                    
                }, completion: nil)
                break;
            case 2:
                self.ana.image = #imageLiteral(resourceName: "lesanalystes-1")
                self.crea.image = #imageLiteral(resourceName: "lescréatifs-1")
                self.make.image = #imageLiteral(resourceName: "lesmakers-1")
                self.desi.image = #imageLiteral(resourceName: "lesdesigners-2")
                UIView.animate(withDuration: 0.4, animations: {
                    self.suiv.alpha = 0
                    
                }, completion: nil)
                break;
            case 3:
                self.ana.image = #imageLiteral(resourceName: "lesanalystes-1")
                self.crea.image = #imageLiteral(resourceName: "lescréatifs-1")
                self.make.image = #imageLiteral(resourceName: "lesmakers-2")
                self.desi.image = #imageLiteral(resourceName: "lesdesigners-1")
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


}
