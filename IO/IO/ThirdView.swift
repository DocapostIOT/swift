//
//  ThirdView.swift
//  IO
//
//  Created by Quentin Gras on 16/12/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit

class ThirdView: UIViewController, UIScrollViewDelegate {

    @IBOutlet var suiv: UIButton!
    @IBOutlet var env: UIImageView!
    @IBOutlet var adn: UIImageView!
    @IBOutlet var prom: UIImageView!
    @IBOutlet var amb: UIImageView!
    @IBOutlet var entit: UIImageView!
    @IBOutlet var scroll: UIScrollView!
    var val = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.frame.size)
        scroll.delegate = self
        var im = UIImage(named: "page2");
        var image = UIImageView()
        image.image = im;
        image.frame = CGRect(x: 0, y: 0, width: CGFloat(4000), height:  CGFloat(700))
        image.sizeToFit()
        scroll.addSubview(image);
        scroll.contentSize.width = image.frame.size.width
        env.isUserInteractionEnabled = true;
        adn.isUserInteractionEnabled = true;
        prom.isUserInteractionEnabled = true;
        amb.isUserInteractionEnabled = true;
        entit.isUserInteractionEnabled = true;
        self.suiv.alpha = 0

      //  entit.image = #imageLiteral(resourceName: "notreentité-2")
        
        switch val{
        case 1:
            self.amb.image = #imageLiteral(resourceName: "notreamtbition-2")
            break;
        case 2:
            self.prom.image = #imageLiteral(resourceName: "notrepromesse-2")
            break;
        case 3:
            self.adn.image = #imageLiteral(resourceName: "notreadn-2")
            break;
        case 0:
            self.entit.image = #imageLiteral(resourceName: "notreentité-2")
            break;
        case 4:
            self.env.image = #imageLiteral(resourceName: "notreenvironnement-2")
            break;
        default:
            break;
        }
        
        self.scroll.contentOffset = CGPoint(x:val * Int(self.view.frame.size.width), y:0)

        
        let recognizer = UITapGestureRecognizer(target: self, action:#selector(env(_:)))
        env.addGestureRecognizer(recognizer)
        let recognizer2 = UITapGestureRecognizer(target: self, action:#selector(adn(_:)))
        adn.addGestureRecognizer(recognizer2)
        let recognizer3 = UITapGestureRecognizer(target: self, action:#selector(prom(_:)))
        prom.addGestureRecognizer(recognizer3)
        let recognizer4 = UITapGestureRecognizer(target: self, action:#selector(amb(_:)))
        amb.addGestureRecognizer(recognizer4)
        let recognizer5 = UITapGestureRecognizer(target: self, action:#selector(entit(_:)))
        entit.addGestureRecognizer(recognizer5)
       // self.view.addSubview(image);
        
    }
    
    func env(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*4, y:0)
        }, completion: nil)
        entit.image = #imageLiteral(resourceName: "notreentité-1")
        adn.image = #imageLiteral(resourceName: "notreadn-1")
        prom.image = #imageLiteral(resourceName: "notrepromesse-1")
        amb.image = #imageLiteral(resourceName: "notreamtbition-1")
        env.image = #imageLiteral(resourceName: "notreenvironnement-2")
        UIView.animate(withDuration: 0.4, animations: {
            self.suiv.alpha = 1
            
        }, completion: nil)
    }
    func adn(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*3, y:0)
        }, completion: nil)
        entit.image = #imageLiteral(resourceName: "notreentité-1")
        adn.image = #imageLiteral(resourceName: "notreadn-2")
        prom.image = #imageLiteral(resourceName: "notrepromesse-1")
        amb.image = #imageLiteral(resourceName: "notreamtbition-1")
        env.image = #imageLiteral(resourceName: "notreenvironnement-1")
        UIView.animate(withDuration: 0.4, animations: {
            self.suiv.alpha = 0
            
        }, completion: nil)
    }
    func prom(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*2, y:0)
        }, completion: nil)
        entit.image = #imageLiteral(resourceName: "notreentité-1")
        adn.image = #imageLiteral(resourceName: "notreadn-1")
        prom.image = #imageLiteral(resourceName: "notrepromesse-2")
        amb.image = #imageLiteral(resourceName: "notreamtbition-1")
        env.image = #imageLiteral(resourceName: "notreenvironnement-1")
        UIView.animate(withDuration: 0.4, animations: {
            self.suiv.alpha = 0
            
        }, completion: nil)
    }
    func amb(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*1, y:0)
        }, completion: nil)
        entit.image = #imageLiteral(resourceName: "notreentité-1")
        adn.image = #imageLiteral(resourceName: "notreadn-1")
        prom.image = #imageLiteral(resourceName: "notrepromesse-1")
        amb.image = #imageLiteral(resourceName: "notreamtbition-2")
        env.image = #imageLiteral(resourceName: "notreenvironnement-1")
        UIView.animate(withDuration: 0.4, animations: {
            self.suiv.alpha = 0
            
        }, completion: nil)
    }
    func entit(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.scroll.contentOffset = CGPoint(x:(self.view.frame.size.width)*0, y:0)
        }, completion: nil)
        entit.image = #imageLiteral(resourceName: "notreentité-2")
        adn.image = #imageLiteral(resourceName: "notreadn-1")
        prom.image = #imageLiteral(resourceName: "notrepromesse-1")
        amb.image = #imageLiteral(resourceName: "notreamtbition-1")
        env.image = #imageLiteral(resourceName: "notreenvironnement-1")
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
        if (v2 >= 4){
            v2 = 4
        }
 
        index = Int(v2)
        
        
        
        var va = v2 * Int(self.view.frame.size.width) ;
        //scroll.setContentOffset( CGPoint(x:va, y:0), animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.scroll.contentOffset = CGPoint(x:va, y:0)
        }, completion:  { (finished) -> Void in
            switch v2{
            case 0:
                self.entit.image = #imageLiteral(resourceName: "notreentité-2")
                self.adn.image = #imageLiteral(resourceName: "notreadn-1")
                self.prom.image = #imageLiteral(resourceName: "notrepromesse-1")
                self.amb.image = #imageLiteral(resourceName: "notreamtbition-1")
                self.env.image = #imageLiteral(resourceName: "notreenvironnement-1")
                UIView.animate(withDuration: 0.4, animations: {
                    self.suiv.alpha = 0
                    
                }, completion: nil)
            break;
            case 1:
                self.entit.image = #imageLiteral(resourceName: "notreentité-1")
                self.adn.image = #imageLiteral(resourceName: "notreadn-1")
                self.prom.image = #imageLiteral(resourceName: "notrepromesse-1")
                self.amb.image = #imageLiteral(resourceName: "notreamtbition-2")
                self.env.image = #imageLiteral(resourceName: "notreenvironnement-1")
                UIView.animate(withDuration: 0.4, animations: {
                    self.suiv.alpha = 0
                    
                }, completion: nil)
            break;
            case 2:
                self.entit.image = #imageLiteral(resourceName: "notreentité-1")
                self.adn.image = #imageLiteral(resourceName: "notreadn-1")
                self.prom.image = #imageLiteral(resourceName: "notrepromesse-2")
                self.amb.image = #imageLiteral(resourceName: "notreamtbition-1")
                self.env.image = #imageLiteral(resourceName: "notreenvironnement-1")
                UIView.animate(withDuration: 0.4, animations: {
                    self.suiv.alpha = 0
                    
                }, completion: nil)
            break;
            case 3:
                self.entit.image = #imageLiteral(resourceName: "notreentité-1")
                self.adn.image = #imageLiteral(resourceName: "notreadn-2")
                self.prom.image = #imageLiteral(resourceName: "notrepromesse-1")
                self.amb.image = #imageLiteral(resourceName: "notreamtbition-1")
                self.env.image = #imageLiteral(resourceName: "notreenvironnement-1")
                UIView.animate(withDuration: 0.4, animations: {
                    self.suiv.alpha = 0
                    
                }, completion: nil)
            break;
            case 4:
                self.entit.image = #imageLiteral(resourceName: "notreentité-1")
                self.adn.image = #imageLiteral(resourceName: "notreadn-1")
                self.prom.image = #imageLiteral(resourceName: "notrepromesse-1")
                self.amb.image = #imageLiteral(resourceName: "notreamtbition-1")
                self.env.image = #imageLiteral(resourceName: "notreenvironnement-2")
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
