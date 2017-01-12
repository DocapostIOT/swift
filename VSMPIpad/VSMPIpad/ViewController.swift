//
//  ViewController.swift
//  VSMPIpad
//
//  Created by Quentin Gras on 22/12/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import CoreBluetooth
import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController , CBPeripheralManagerDelegate, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    var player:AVPlayer?;
    var playerViewController:AVPlayerViewController?;
    
    var once = true;
    var vid = 0;
    var auto = true;
    var val = 0;
    func playVid(name : String){
        NSLog(name);
        
        
        if (auto){
            vid = Int(name)!;
        }
        let urlpath     = Bundle.main.path(forResource: name, ofType: "mp4")
        let url         = NSURL.fileURL(withPath: urlpath!)
        if(once){
            player = AVPlayer(url: url as URL)
            
            
            playerViewController = AVPlayerViewController()
            playerViewController?.view.transform =  CGAffineTransform(rotationAngle: CGFloat.pi / 2)
            playerViewController?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.height, height: self.view.frame.width)
            playerViewController?.player = player
            playerViewController?.showsPlaybackControls = false
            playerViewController?.view.frame = self.view.frame
            self.view.addSubview(playerViewController!.view);
            
            once = false;
            
        }
        
        
        
        if (auto){
            player?.volume = 0
        }
        else{
            player?.volume = 10
        }
        
        var item = AVPlayerItem.init(url: url)
        
        
        self.player?.replaceCurrentItem(with: item)
        NotificationCenter.default.removeObserver(self);
        NotificationCenter.default.addObserver(self, selector: #selector(self.itemDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem);
        self.playerViewController?.player!.play()
        
        if (!auto){
            self.playerViewController?.player!.pause()
        }
    }
    
    
    
    func itemDidFinishPlaying(){
        print("end");
        if (auto){
            // DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            switch self.vid{
            case 110:
                self.vid = 200;
                break
            case 209:
                self.vid = 300;
                break
            case 311:
                self.vid = 100;
                break
                       default :
                self.vid = self.vid+1;
                break
            }
            let str = String(self.vid);
            self.playVid(name: str);
            //  })
        }
        else{
            
            let message = "end";
            let data = NSData.init(bytes: message, length: message.characters.count);
            let str = String(self.vid);
            if str != "111" && str != "210" && str != "312"{
                self.playVid(name: str);
            }
            print(peripheralManager?.updateValue(data as Data, for: characteristicNot!, onSubscribedCentrals: nil));
        }
        
    }
    
    
    /*
     **
     **
     ** Central
     **
     **
     */
    
    var centralManager:CBCentralManager?;
    var per:CBPeripheral?;
    var color:CBCharacteristic?;
    var brightness:CBCharacteristic?;
    
    
    @IBAction func action(_ sender: AnyObject) {
        /*  var message = 255;
         let data = NSData.init(bytes: &message, length: 3);
         print(per?.writeValue(data as Data, for: color!, type: .withResponse));*/
        auto = true
        playVid(name: "100");
    }
    
    func peripheral(_ peripheral: CBPeripheral,
                    didWriteValueFor characteristic: CBCharacteristic,
                    error: Error?){
        print(error);
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber){
        print("name: %s",peripheral.name);
        if (peripheral.name == "SML-c4-GU10"){
            per = peripheral;
            centralManager?.stopScan();
            centralManager?.connect(peripheral, options: nil);
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral){
        per = peripheral;
        per?.delegate = self;
        per?.discoverServices(nil);
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDisconnectPeripheral peripheral: CBPeripheral,
                        error: Error?){
        central.scanForPeripherals(withServices: nil, options: nil /*[CBCentralManagerScanOptionAllowDuplicatesKey : true]*/);
        
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
            if ( char.uuid.description == "74532143-FFF1-460D-8E8A-370F934D40BE"){
                color = char;
                print("read ok ");
                
            }
            if ( char.uuid.description == "1C537B0A-4EAA-4E19-B98C-EAAA5BCD9BC9"){
                brightness = char;
                print("not ok ");
                var message = 0;
                let data = NSData.init(bytes: &message, length: 3);
                print(per?.writeValue(data as Data, for: brightness!, type: .withResponse));
                //ral.setNotifyValue(true, for: characteristicNot!);
            }
            
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        if (central.state == .poweredOn) {
            central.scanForPeripherals(withServices: nil, options: nil /*[CBCentralManagerScanOptionAllowDuplicatesKey : true]*/);
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
    var characteristicNot:CBMutableCharacteristic?;
    var characteristicRead:CBMutableCharacteristic?;
    var peripheralManager:CBPeripheralManager?;
    var cent:CBCentralManager?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager.init(delegate: self, queue: nil);
        peripheralManager = CBPeripheralManager.init(delegate: self, queue: nil);
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func peripheralManager(_ peripheral: CBPeripheralManager,
                           didReceiveWrite requests: [CBATTRequest]){
        for req in requests{
            var str = "";
            for x in req.value!{
                str.append(Character(UnicodeScalar(x)));
            }
            
            NSLog(str);
            if (str == "100" || str == "200" || str == "300"){
                auto = false;
                var message = 16777215
                var data = NSData.init(bytes: &message, length: 3);
                print(per?.writeValue(data as Data, for: color!, type: .withResponse));
                var message2 = 100;
                self.vid = Int(str)! + 1
                playVid(name: str);
                playerViewController?.player!.play()
                data = NSData.init(bytes: &message2, length: 3);
                print(per?.writeValue(data as Data, for: brightness!, type: .withResponse));
            }
            else if(str == "110" || str == "209" || str == "311"){
                auto = false;
                self.vid = Int(str)! + 1
                playerViewController?.player!.play()
                var message = 0;
                let data = NSData.init(bytes: &message, length: 3);
                print(per?.writeValue(data as Data, for: brightness!, type: .withResponse));
            }
            else if (str == "auto"){
                auto = true;
                val = 11;
                playVid(name: "100");
                
                
            }
            else if (str == "stop"){
                auto = false;
                player?.pause();
                var message = 0;
                let data = NSData.init(bytes: &message, length: 3);
                print(per?.writeValue(data as Data, for: brightness!, type: .withResponse));
                
            }
            else{
                auto = false;
                self.vid = Int(str)! + 1
                playerViewController?.player!.play()
            }
        }
        
        
    }
    
    @IBAction func opai(_ sender: AnyObject) {
        let message = "valie";
        let data = NSData.init(bytes: message, length: message.characters.count);
        print(peripheralManager?.updateValue(data as Data, for: characteristicNot!, onSubscribedCentrals: nil));
        
        print("send message");
    }
    
    
    func peripheralManager(_ peripheral: CBPeripheralManager,
                           central: CBCentral,
                           didSubscribeTo characteristic: CBCharacteristic){
        print("Connect");
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager,
                           central: CBCentral,
                           didUnsubscribeFrom characteristic: CBCharacteristic){
        print("Deconnect");
        /* auto = true;
         val = 11;
         playVid(name: "11");*/
    }
    
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager){
        if(peripheral.state == .poweredOn){
            service1 = CBMutableService.init(type: CBUUID.init(string:"A6CD6F10-8710-4695-A915-6DF8727E0F44"), primary: true);
            characteristicNot = CBMutableCharacteristic.init(type: CBUUID.init(string: "E876FC49-77FE-42AC-A53A-90F9D3F9FC44"), properties: .notify, value: nil, permissions: .readable);
            characteristicRead = CBMutableCharacteristic.init(type: CBUUID.init(string: "E876FC49-77FE-42AC-A53A-90F9D3F9FC45"), properties: .writeWithoutResponse, value: nil, permissions: .writeable);
            service1?.characteristics = [characteristicNot!, characteristicRead!];
            peripheralManager?.add(service1!);
            peripheralManager?.startAdvertising([CBAdvertisementDataLocalNameKey : "IpadDemoCES", CBAdvertisementDataServiceUUIDsKey:[CBUUID.init(string: "A6CD6F10-8710-4695-A915-6DF8727E0F44")]]);
            print("Start advertising");
            
        }
        else{
            print("Failed to init Bluetooth");
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

