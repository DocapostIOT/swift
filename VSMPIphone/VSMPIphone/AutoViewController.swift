//
//  AutoViewController.swift
//  VSMPIphone
//
//  Created by Quentin Gras on 23/12/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit
import CoreBluetooth

class AutoViewController: UIViewController ,CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager:CBCentralManager?;
    var peripheralManager:CBPeripheral?;
    var characteristicNot:CBCharacteristic?;
    var characteristicRead:CBCharacteristic?;
    
    var vidConnected = true;
    
    
    
    var scene:Int = 0;
    var vid:Int = 0;
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc:ViewController = segue.destination as! ViewController;
        vc.vidConnected = vidConnected;
        
    }
    @IBAction func stop(_ sender: AnyObject) {
        let str = "stop";
        let data = NSData.init(bytes: str, length: str.characters.count);
        print(peripheralManager?.writeValue(data as Data, for: characteristicRead!, type: .withoutResponse));
        
        self.performSegue(withIdentifier: "back", sender: self);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = ViewController.central;
        peripheralManager = ViewController.per;
        characteristicNot = ViewController.not;
        characteristicRead = ViewController.read;
        centralManager?.delegate = self;
        peripheralManager?.delegate = self;
        vid = 1;
        
        
        var message = "";
        
        message.append(String(describing: scene));
        message.append(String(describing: vid));
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func peripheral(_ peripheral: CBPeripheral,
                    didWriteValueFor characteristic: CBCharacteristic,
                    error: Error?){
        print(error);
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber){
        print("name: %s",peripheral.name);
        //if (peripheral.name == "MacBook Pro de Quntin"){
        peripheralManager = peripheral;
        centralManager?.stopScan();
        centralManager?.connect(peripheral, options: nil);
        
        //}
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDisconnectPeripheral peripheral: CBPeripheral,
                        error: Error?){
        vidConnected = false;
        self.performSegue(withIdentifier: "back", sender: self);
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral){
        peripheralManager = peripheral;
        peripheralManager?.delegate = self;
        ViewController.per = peripheral;
        peripheralManager?.discoverServices(nil);
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?){
        for x in peripheral.services!{
            peripheral.discoverCharacteristics(nil, for: x);
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                    error: Error?){
        print("%s", service.uuid.description);
        for char in service.characteristics!{
            print("char: %s", char.uuid.description);
            if ( char.uuid.description == "E876FC49-77FE-42AC-A53A-90F9D3F9FC45"){
                characteristicRead = char;
                ViewController.read = char;
                print("read ok ");
                
            }
            if ( char.uuid.description == "E876FC49-77FE-42AC-A53A-90F9D3F9FC44"){
                characteristicNot = char;
                ViewController.not = char;
                print("not ok ");
                peripheral.setNotifyValue(true, for: characteristicNot!);
            }
            
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        if (central.state == .poweredOn) {
            central.scanForPeripherals(withServices: [CBUUID.init(string: "A6CD6F10-8710-4695-A915-6DF8727E0F44")], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true]);
        }
        else{
            print("Failed to init Bluetooth");
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral,
                    didUpdateNotificationStateFor characteristic: CBCharacteristic,
                    error: Error?){
        if ((error) != nil)
        {
            print(error);
        }
        var str = "";
        print("Notify");
        /*for x in characteristic.value!{
         str.append(Character(UnicodeScalar(x)));
         }
         NSLog(str);*/
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        var str = "";
        
        for x in characteristic.value!{
            str.append(Character(UnicodeScalar(x)));
        }
        NSLog(str);
        
    }
        

}
