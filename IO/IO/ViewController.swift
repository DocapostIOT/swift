//
//  ViewController.swift
//  IO
//
//  Created by Quentin Gras on 16/12/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView2 = UIImageView(image: UIImage.gifLast("gifIO"))
        imageView = UIImageView(image: UIImage(named: "heart"))
        imageView.animationImages = UIImage.gifImageWithName("gifIO")
        imageView.animationDuration = 5
        imageView.animationRepeatCount = 1
        imageView.frame = self.view.frame
        imageView2.frame = self.view.frame
        
       // view.addSubview(imageView2)
        
        //view.addSubview(imageView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
       
       // imageView.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

