//
//  sommeViewController.swift
//  IO
//
//  Created by Quentin Gras on 20/12/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit

class sommeViewController: UIViewController {

    var val = 0;
    @IBAction func but1(_ sender: Any) {
        val = 0;
        self.performSegue(withIdentifier: "go", sender: self);
    }
    @IBAction func but2(_ sender: Any) {
        val = 1;
        self.performSegue(withIdentifier: "go", sender: self);
    }
    @IBAction func but3(_ sender: Any) {
        val = 2;
        self.performSegue(withIdentifier: "go", sender: self);
    }
    @IBAction func but4(_ sender: Any) {
        val = 3;
        self.performSegue(withIdentifier: "go", sender: self);
    }
    @IBAction func but5(_ sender: Any) {
        val = 4;
        self.performSegue(withIdentifier: "go", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "go"){
            (segue.destination as! ThirdView).val = val
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
