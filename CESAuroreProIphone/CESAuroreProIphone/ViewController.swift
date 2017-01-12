//
//  ViewController.swift
//  CESAuroreProIphone
//
//  Created by Quentin Gras on 08/11/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit
import CoreBluetooth


var once = true;


class ViewController: UIViewController, CBCentralManagerDelegate , CBPeripheralDelegate, CBPeripheralManagerDelegate{
    @IBOutlet var Auto: UIButton!

    @IBOutlet var scene7: UIButton!
    @IBOutlet var Scene6: UIButton!
    @IBOutlet var Scene5: UIButton!
    @IBOutlet var Scene4: UIButton!
    @IBOutlet var Scene3: UIButton!
    @IBOutlet var scene1: UIButton!
    @IBOutlet var Scene2: UIButton!
    @IBOutlet var indicator: UIActivityIndicatorView!
    var vidConnected = false;
    var UIConnected = false;
    var centralManager:CBCentralManager?;
    struct Static {
        static var items = CBCentralManager();
        static var per :CBPeripheral?;
        static var not :CBCharacteristic?;
        static var read : CBCharacteristic?;
        
        static var per2 :CBPeripheralManager?;
        static var not2 :CBMutableCharacteristic?;
    }
    class var central: CBCentralManager {
        get { return Static.items }
        set { Static.items = newValue }
    }
    class var per: CBPeripheral {
        get { return Static.per! }
        set { Static.per = newValue }
    }
    class var not: CBCharacteristic {
        get { return Static.not! }
        set { Static.not = newValue }
    }
    class var read: CBCharacteristic {
        get { return Static.read! }
        set { Static.read = newValue }
    }
    
    class var per2: CBPeripheralManager {
        get { return Static.per2! }
        set { Static.per2 = newValue }
    }
    class var not2: CBMutableCharacteristic {
        get { return Static.not2! }
        set { Static.not2 = newValue }
    }
   
    var peripheralManager:CBPeripheral? = nil;
    var characteristicNot:CBCharacteristic? = nil;
    var characteristicRead:CBCharacteristic? = nil;
    var sceneVal = 1;
    
    @IBAction func but7(_ sender: Any) {
        sceneVal = 7;
        self.performSegue(withIdentifier: "second", sender: self);
    }
    
    @IBAction func auto(_ sender: AnyObject) {
      
       let message = "auto";
       let data = NSData.init(bytes: message, length: message.characters.count);
        print(peripheralManager?.writeValue(data as Data, for: characteristicRead!, type: .withoutResponse));
        self.performSegue(withIdentifier: "stop", sender: self);

    }
    @IBAction func but6(_ sender: AnyObject) {

        sceneVal = 6;
        self.performSegue(withIdentifier: "second", sender: self);
        
    }
    @IBAction func but5(_ sender: AnyObject) {

        sceneVal = 5;

        self.performSegue(withIdentifier: "second", sender: self);
    }
    @IBAction func but4(_ sender: AnyObject) {

        sceneVal = 4;

        self.performSegue(withIdentifier: "second", sender: self);
    }
    @IBAction func but2(_ sender: AnyObject) {
    
        sceneVal = 2;
        self.performSegue(withIdentifier: "second", sender: self);
    }
    
    @IBAction func but3(_ sender: AnyObject) {

        sceneVal = 3;

        self.performSegue(withIdentifier: "second", sender: self);
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "second"){
            let vc:SecondViewController = segue.destination as! SecondViewController;
            vc.scene = sceneVal;
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.hidesWhenStopped = true;
        if (!vidConnected || !UIConnected){
            startAnimat()
        }
        if (once){
            centralManager = CBCentralManager.init(delegate: self, queue: nil);
            peripheralManagerper = CBPeripheralManager.init(delegate: self, queue: nil);
            Static.per2 = peripheralManagerper;
            once = false;
        }
        else{
            centralManager = ViewController.central;
            peripheralManager = ViewController.per;
            characteristicNot = ViewController.not;
            characteristicRead = ViewController.read;
            centralManager?.delegate = self;
            peripheralManager?.delegate = self;
        }
        Static.items = centralManager!;
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func action(_ sender: AnyObject) {
        sceneVal = 1;
        self.performSegue(withIdentifier: "second", sender: self);
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
            Static.per = peripheral;
            centralManager?.stopScan();
            centralManager?.connect(peripheral, options: nil);
            
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral){
       // peripheralManager = peripheral;
        peripheralManager?.delegate = self;
        peripheralManager?.discoverServices(nil);
        vidConnected = true;
        if (vidConnected && UIConnected){
            stopAnimat()
        }
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDisconnectPeripheral peripheral: CBPeripheral,
                        error: Error?){
        vidConnected = false;
        startAnimat()
        central.scanForPeripherals(withServices: [CBUUID.init(string: "A6CD6F10-8710-4695-A915-6DF8727E0F54")], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true]);
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
                        Static.read = char;
                    
                    print("read ok ");
                    
                }
                if ( char.uuid.description == "E876FC49-77FE-42AC-A53A-90F9D3F9FC44"){
                        characteristicNot = char;
                        Static.not = char;
                  
                    print("not ok ");
                    peripheral.setNotifyValue(true, for: characteristicNot!);
                }
            
            }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        if (central.state == .poweredOn) {
            central.scanForPeripherals(withServices: [CBUUID.init(string: "A6CD6F10-8710-4695-A915-6DF8727E0F54")], options: [CBCentralManagerScanOptionAllowDuplicatesKey : false]);
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

    
    /*
     **
     **
     ** Peripheral
     **
     **
     */
    var service1:CBMutableService?;
    var characteristicNotper:CBMutableCharacteristic?;
    var characteristicReadper:CBMutableCharacteristic?;
    var peripheralManagerper:CBPeripheralManager?;
    var cent:CBCentralManager?;
    
    
    func peripheralManager(_ peripheral: CBPeripheralManager,
                           didReceiveWrite requests: [CBATTRequest]){
        for req in requests{
            var str = "";
            for x in req.value!{
                str.append(Character(UnicodeScalar(x)));
            }
            
            NSLog(str);
        }
        
        
    }
    

    
    func peripheralManager(_ peripheral: CBPeripheralManager,
                           central: CBCentral,
                           didSubscribeTo characteristic: CBCharacteristic){
        print("Connect");
        UIConnected = true;
        if (vidConnected && UIConnected){
            stopAnimat()
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager,
                           central: CBCentral,
                           didUnsubscribeFrom characteristic: CBCharacteristic){
        UIConnected = false;
        startAnimat()
        print("Deconnect");

    }
    func startAnimat(){
        indicator.startAnimating();
        scene1.isEnabled = false;
        Scene2.isEnabled = false;
        Scene3.isEnabled = false;
        Scene4.isEnabled = false;
        Scene5.isEnabled = false;
        Scene6.isEnabled = false;
        scene7.isEnabled = false;
        Auto.isEnabled = false;

    }
    
    func stopAnimat(){
        indicator.stopAnimating();
        scene1.isEnabled = true;
        Scene2.isEnabled = true;
        Scene3.isEnabled = true;
        Scene4.isEnabled = true;
        Scene5.isEnabled = true;
        Scene6.isEnabled = true;
        scene7.isEnabled = true;
        Auto.isEnabled = true;


    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager){
        if(peripheral.state == .poweredOn){
            service1 = CBMutableService.init(type: CBUUID.init(string:"A6CD6F10-8710-4695-A915-6DF8727E0F55"), primary: true);
            characteristicNotper = CBMutableCharacteristic.init(type: CBUUID.init(string: "E876FC49-77FE-42AC-A53A-90F9D3F9FC44"), properties: .notify, value: nil, permissions: .readable);
            characteristicReadper = CBMutableCharacteristic.init(type: CBUUID.init(string: "E876FC49-77FE-42AC-A53A-90F9D3F9FC45"), properties: .write, value: nil, permissions: .writeable);
            service1?.characteristics = [characteristicNotper!, characteristicReadper!];
            Static.not2 = characteristicNotper
            peripheralManagerper?.add(service1!);
            peripheralManagerper?.startAdvertising([CBAdvertisementDataLocalNameKey : "IphoneCommandeCES", CBAdvertisementDataServiceUUIDsKey:[CBUUID.init(string: "A6CD6F10-8710-4695-A915-6DF8727E0F55")]]);
            print("Start advertising");
            
        }
        else{
            print("Failed to init Bluetooth");
        }
    }
    

}

