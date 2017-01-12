//
//  demnavViewController.swift
//  IO
//
//  Created by Quentin Gras on 22/12/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit

class demnavViewController: UIViewController {

    var val = 0
    @IBAction func launch(_ sender: Any) {
        val = 2;
        self.performSegue(withIdentifier: "go", sender: self);
    }
    @IBAction func think(_ sender: Any) {
        val = 0;
        self.performSegue(withIdentifier: "go", sender: self);
    }
    
    @IBAction func `do`(_ sender: Any) {
        val = 1;
        self.performSegue(withIdentifier: "go", sender: self);
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "go"){
            (segue.destination as! demViewController).val = val
        }
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
