//
//  Navigation.swift
//  CESAuroreIphoneDemo
//
//  Created by Quentin Gras on 16/11/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit

class Navigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "init", sender: self);
        // Do any additional setup after loading the view.
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
