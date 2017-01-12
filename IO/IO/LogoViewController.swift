//
//  LogoViewController.swift
//  IO
//
//  Created by Quentin Gras on 21/12/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit

extension CGFloat {
    func radians() -> CGFloat {
        let b = CGFloat(M_PI) * (self/180)
        return b
    }
}

var once = true;


class LogoViewController: UIViewController {

    
   

    
    @IBOutlet var nav: UIImageView!
    @IBOutlet var bas: UIImageView!
    var array : [Circle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.478, green: 0.820, blue: 0.843, alpha: 1.00)
      
     
        array.removeAll()
        
        for i in 0...4{
            var v = Int(110) + Int(i * 30)
            for i in polygonPointArray(sides: 40, x: self.view.frame.width / 2, y: self.view.frame.height / 2, radius: CGFloat(v), offset: 0){
                
                var v = self.view.frame.width * 2
                let randomNumx:UInt32 = arc4random_uniform(UInt32(v)) // range is 0 to 99
                let x:Int = Int(randomNumx)
                
                
                v = self.view.frame.height * 2
                let randomNumy:UInt32 = arc4random_uniform(UInt32(v)) // range is 0 to 99
                let y:Int = Int(randomNumy)
                
                
                let randomNums:UInt32 = arc4random_uniform(5) // range is 0 to 99
                var s:Int = Int(randomNums)
                
                s += 4
                
                
                var particle = Circle(frame: CGRect(x: CGFloat(x) - self.view.frame.width / 2, y: CGFloat(y) - self.view.frame.height / 2, width: CGFloat(s) , height: CGFloat(s)) , color: UIColor.white)
                particle.dest = CGRect(x: i.x, y: i.y, width: 5, height: 5)
                array.append(particle)
                self.view.addSubview(particle)
            }
        }
        
        nav.alpha = 0
        bas.alpha = 0
        if (!once){
            
            
            for particle in self.array{
                particle.frame = particle.dest
            }
            
            self.nav.alpha = 1
            self.bas.alpha = 1
        }
        let recognizer = UITapGestureRecognizer(target: self, action:#selector(env(_:)))
        self.view.addGestureRecognizer(recognizer)
        // Do any additional setup after loading the view.
    }

    func env(_ recognizer: UITapGestureRecognizer) {
        if once{
            UIView.animate(withDuration: 5, animations: {
            for particle in self.array{
                particle.frame = particle.dest
            }
            }, completion: { (Finised) -> Void in
                UIView.animate(withDuration: 0.4, animations: {
                self.nav.alpha = 1
                self.bas.alpha = 1
                }, completion: nil)
            }
            )
            once = false
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
       /* array.removeAll()
        nav.alpha = 0
        bas.alpha = 0
        for i in 0...4{
            var v = Int(110) + Int(i * 30)
            for i in polygonPointArray(sides: 40, x: self.view.frame.width / 2, y: self.view.frame.height / 2, radius: CGFloat(v), offset: 0){
                
                var v = self.view.frame.width * 2
                let randomNumx:UInt32 = arc4random_uniform(UInt32(v)) // range is 0 to 99
                let x:Int = Int(randomNumx)
                
                
                v = self.view.frame.height * 2
                let randomNumy:UInt32 = arc4random_uniform(UInt32(v)) // range is 0 to 99
                let y:Int = Int(randomNumy)
                
                
                let randomNums:UInt32 = arc4random_uniform(3) // range is 0 to 99
                var s:Int = Int(randomNums)
                
                s += 3
                
                
                var particle = Circle(frame: CGRect(x: CGFloat(x) - self.view.frame.width / 2, y: CGFloat(y) - self.view.frame.height / 2, width: CGFloat(s) , height: CGFloat(s)) , color: UIColor.white)
                particle.dest = CGRect(x: i.x, y: i.y, width: 3, height: 3)
                array.append(particle)
                self.view.addSubview(particle)
            }
        }*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if (!once){
        
      
            for particle in self.array{
                particle.frame = particle.dest
            }
      
                self.nav.alpha = 1
                self.bas.alpha = 1
        }
    }
    
    
    func polygonPointArray(sides:Int,x:CGFloat,y:CGFloat,radius:CGFloat,offset:CGFloat)->[CGPoint] {
        let angle = (360/CGFloat(sides)).radians()
        let cx = x // x origin
        let cy = y // y origin
        let r = radius // radius of circle
        var i = 0
        var points = [CGPoint]()
        while i <= sides {
            let xpo = cx + r * cos(angle * CGFloat(i) - offset.radians())
            let ypo = cy + r * sin(angle * CGFloat(i) - offset.radians())
            points.append(CGPoint(x: xpo, y: ypo))
            i += 1
        }
        return points
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
