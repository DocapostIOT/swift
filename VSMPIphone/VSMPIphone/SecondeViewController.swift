//
//  SecondeViewController.swift
//  VSMPIphone
//
//  Created by Quentin Gras on 23/12/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit
import CoreBluetooth


class SecondeViewController: UIViewController , CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager:CBCentralManager?;
    var peripheralManager:CBPeripheral?;
    var characteristicNot:CBCharacteristic?;
    var characteristicRead:CBCharacteristic?;
    
    var vidConnected = true;
    
    
    
    var scene:Int = 0;
    @IBOutlet var text: UITextView!
    @IBOutlet var but: UIButton!
    
    var hashmap: [String: String] = [:];
    var ha: [String: String] = [:];
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc:ViewController = segue.destination as! ViewController;
        vc.vidConnected = vidConnected;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = ViewController.central;
        peripheralManager = ViewController.per;
        characteristicNot = ViewController.not;
        characteristicRead = ViewController.read;
        centralManager?.delegate = self;
        peripheralManager?.delegate = self;
        scene *= 100
        initHash();
        var message = "";
        
        message.append(String(describing: scene));
        let data = NSData.init(bytes: message, length: message.characters.count);
        print(peripheralManager?.writeValue(data as Data, for: characteristicRead!, type: .withoutResponse));

        
        but.isEnabled = false;
        self.view.backgroundColor = UIColor.red;
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func next(_ sender: AnyObject) {
        var message = "";
        
        message.append(String(describing: scene));
        let data = NSData.init(bytes: message, length: message.characters.count);
        print(peripheralManager?.writeValue(data as Data, for: characteristicRead!, type: .withoutResponse));
        but.isEnabled = false;
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
        if(str == "end"){
            but.isEnabled = true;
            scene += 1;
            var message = "";
            
            message.append(String(describing: scene));
            
            if ((hashmap[message]) == nil){
                
                self.performSegue(withIdentifier: "back", sender: self);
            }
            else{
                text.text = hashmap[message];
                if(ha[message] == "F"){
                    self.view.backgroundColor = UIColor.white;
                }
                else{
                    self.view.backgroundColor = UIColor.red;
                }
            }
        }
    }
    
    

    
    @IBAction func back(_ sender: Any) {
        let str = "stop";
        let data = NSData.init(bytes: str, length: str.characters.count);
        print(peripheralManager?.writeValue(data as Data, for: characteristicRead!, type: .withoutResponse));
        
        self.performSegue(withIdentifier: "back", sender: self);
    }
 
    func initHash(){
        
        
        hashmap["100"] = "";
        hashmap["101"] = "Bonjour George \nQuoi de neuf aujourd’hui ?";
        hashmap["102"] = "Bonjour Pierre\nIl va faire très beau : 19° ce matin et 23° cet après-midi";
        hashmap["103"] = "Je vous rappelle que vous avez un passage facteur programmé aujourd’hui à 15h.";
        hashmap["104"] = "Merci George. Pourrais-tu me commander du lait pour que je fasse des crêpes à mes petits enfants ?";
        hashmap["105"] = "C’est noté Pierre. Avez-vous suffisamment d’oeufs et de farine ?";
        hashmap["106"] = "Oui merci George";
        hashmap["107"] = "Je vous en prie. J’ai passé commande et transmis le message au facteur. Il vous l’apportera lors de sa visite !";
        hashmap["108"] = "Avez-vous besoin d’autre chose ?";
        hashmap["109"] = "Non, ça ira.";
        hashmap["110"] = "Très bien. Je vous souhaite une bonne journée.";

        
        
        hashmap["200"] = "";
        hashmap["201"] = "Bonjour George !\nQuoi de neuf ?";
        hashmap["202"] = "Bonjour Michèle. C’est une belle journée ensoleillée qui commence.";
        
        hashmap["203"] = "Je vous rappelle que vous avez un passage facteur programmé demain à 14h.";
        hashmap["204"] = "Merci George. Par ailleurs, je n’ai plus de médicaments. Peux-tu demander au facteur de m’apporter la commande que j’ai passée au pharmacien ?";
        hashmap["205"] = "C’est noté Michèle. J’ai transmis le message au facteur. Il vous les apportera lors de sa visite !";
        hashmap["206"] = "Très bien, merci George.";
        hashmap["207"] = "Je vous en prie. Avez-vous besoin d’autre chose ?";
        hashmap["208"] = "Non, ça ira.";
        hashmap["209"] = "Très bien. Je vous souhaite une bonne journée.";
        
        
        
        hashmap["300"] = "";
        hashmap["301"] = "Bonjour George ! Quoi de neuf aujourd’hui ?";
        hashmap["302"] = "Bonjour Jacqueline.\nIl va faire très beau aujourd’hui.Pensez à vous hydrater.";
        hashmap["303"] = "Je vous rappelle par ailleurs que vous avez un passage facteur programmé cet après-midi à 16h";
        hashmap["304"] = "C’est noté. Merci George. A propos, j’ai terminé les livres que j’ai empruntés la semaine dernière et j’en souhaiterais des nouveaux.";
        hashmap["305"] = "Je vais transmettre le message au facteur. Souhaitez-vous d’autres romans du même auteur ?";
        hashmap["306"] = "Oui";
        hashmap["307"] = "Germinal et La bête humaine vous conviendraient-ils ?";
        hashmap["308"] = "C’est parfait. Merci George !";
        hashmap["309"] = "Je vous en prie.\nAvez-vous besoin d’autre chose ?";
        hashmap["310"] = "Non, ça ira, merci !";
        hashmap["311"] = "Très bien. Passez une bonne journée Jacqueline !";
     
        

        
        
        
        
        ha["100"] = "";
        ha["101"] = "F";
        ha["102"] = "G";
        ha["103"] = "G";
        ha["104"] = "F";
        ha["105"] = "G";
        ha["106"] = "F";
        ha["107"] = "G";
        ha["108"] = "G";
        ha["109"] = "F";
        ha["110"] = "G";
        
        
        
        ha["200"] = "";
        ha["201"] = "F";
        ha["202"] = "G";
        ha["203"] = "G";
        ha["204"] = "F";
        ha["205"] = "G";
        ha["206"] = "F";
        ha["207"] = "G";
        ha["208"] = "F";
        ha["209"] = "G";
        
        
        
        ha["300"] = "";
        ha["301"] = "F";
        ha["302"] = "G";
        ha["303"] = "G";
        ha["304"] = "F";
        ha["305"] = "G";
        ha["306"] = "F";
        ha["307"] = "G";
        ha["308"] = "F";
        ha["309"] = "G";
        ha["310"] = "F";
        ha["311"] = "G";
    
        
    }

}
