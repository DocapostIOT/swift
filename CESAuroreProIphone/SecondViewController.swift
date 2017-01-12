//
//  SecondViewController.swift
//  CESAuroreProIphone
//
//  Created by Quentin Gras on 14/11/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit
import CoreBluetooth


class SecondViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate, CBPeripheralManagerDelegate {

    var centralManager:CBCentralManager?;
    var peripheralManager:CBPeripheral?;
    var characteristicNot:CBCharacteristic?;
    var characteristicRead:CBCharacteristic?;
    
    var vidConnected = true;
    var UIConnected = true;
    
    
    var peripheralManager2:CBPeripheralManager?;
    var characteristicNot2:CBMutableCharacteristic?;
    
    var scene:Int = 0;
    @IBOutlet var text: UITextView!
    @IBOutlet var but: UIButton!

    var hashmap: [String: String] = [:];
    var ha: [String: String] = [:];
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc:ViewController = segue.destination as! ViewController;
        vc.vidConnected = vidConnected;
        vc.UIConnected = UIConnected;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = ViewController.central;
        peripheralManager = ViewController.per;
        characteristicNot = ViewController.not;
        characteristicRead = ViewController.read;
        peripheralManager2 = ViewController.per2;
        characteristicNot2 = ViewController.not2;
        centralManager?.delegate = self;
        peripheralManager?.delegate = self;
        peripheralManager2?.delegate = self;
        scene *= 100
        initHash();
        var message = "";
        
        message.append(String(describing: scene));
        let data = NSData.init(bytes: message, length: message.characters.count);
        print(peripheralManager?.writeValue(data as Data, for: characteristicRead!, type: .withoutResponse));
        print(peripheralManager2?.updateValue(data as Data, for: characteristicNot2!, onSubscribedCentrals: nil));
        
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
        print(peripheralManager2?.updateValue(data as Data, for: characteristicNot2!, onSubscribedCentrals: nil));

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
            central.scanForPeripherals(withServices: [CBUUID.init(string: "A6CD6F10-8710-4695-A915-6DF8727E0F54")], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true]);
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
    
    
    @IBAction func back(_ sender: Any) {
        let str = "stop";
        let data = NSData.init(bytes: str, length: str.characters.count);
        print(peripheralManager?.writeValue(data as Data, for: characteristicRead!, type: .withoutResponse));
        
        self.performSegue(withIdentifier: "back", sender: self);
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager,
                           central: CBCentral,
                           didSubscribeTo characteristic: CBCharacteristic){
        print("Connect");
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager,
                           central: CBCentral,
                           didUnsubscribeFrom characteristic: CBCharacteristic){
        UIConnected = false;
        self.performSegue(withIdentifier: "back", sender: self);
        print("Deconnect");
        
    }
    
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager){
        if(peripheral.state == .poweredOn){
          
            print("Start advertising");
            
        }
        else{
            print("Failed to init Bluetooth");
        }
    }
    
    func initHash(){
        
        
        hashmap["100"] = "";
        hashmap["101"] = "Bonjour George, quelles sont les nouvelles du matin ?";
        hashmap["102"] = "Bonjour Fred, tu as 3 nouveaux messages.\nSouhaites-tu les écouter ?";
        hashmap["103"] = "Non merci. Rappelle-le-moi plus tard s’il-te-plaît.";
        hashmap["104"] = "Très bien, je te le rappellerai dans une heure.";
        hashmap["105"] = "Tu as 5 rendez-vous dans la journée.\nLe 1er chez ton comptable Monsieur Lombard à 11h30 rue Lourmel dans le 15ème arrondissement.";
        hashmap["106"] = "Merci George, peux-tu me conseiller le meilleur moyen de m’y rendre ?";
        hashmap["107"] = "Il y a du trafic sur la route, je te conseille les transports en commun.\nTu peux prendre le métro 6 et descendre à Bir Hakeim.- Tour Eiffel.";
        hashmap["108"] = "";
        hashmap["109"] = "Prévois ensuite 10 minutes de marche à la sortie du métrole long des quais de Seine et pars dans 5 minutes.";
        hashmap["110"] = "Avec ce trajet tu feras 8% de ton nombre de pas journaliers conseillé.";
        hashmap["111"] = "Pense à prendre ton parapluie, il risque de pleuvoir.";
        hashmap["112"] = "Parfait, merci, à tout à l’heure.";
    
        
        hashmap["200"] = "";
        hashmap["201"] = "George j’ai besoin de ne pas être dérangé. Bascule tous mes appels vers le secrétariat s’il-te-plaît !";
        hashmap["202"] = "Très bien, tous tes appels sont maintenant basculés.";
        
        hashmap["300"] = "";
        hashmap["301"] = "George, peux-tu prévenir le facteur qu’il doit venir prendre un colis dès que possible?";
        hashmap["302"] = "Demande transmise.\nLe facteur passera récupérer le colis demain entre 10h et midi, cela te convient?";
        hashmap["303"] = "Ok.";
        hashmap["304"] = "La demande de retrait est confirmée.";
        hashmap["305"] = "George, peux-tu me dire maintenant où en est l’envoi de mon colis envoyé à la société Monbusiness lundi ?";
        hashmap["306"] = "Il est arrivé à destination ! ";
        
        hashmap["400"] = "";
        hashmap["401"] = "Georges peux-tu informer mes clients pour le show room nocturne de jeudi ?";
        hashmap["402"] = "Ok.";
        hashmap["403"] = "163 SMS et 234 mails ont été envoyés à tes clients.";
        
        
        hashmap["500"] = "";
        hashmap["501"] = "George, Monsieur Carilla me demande de lui renvoyer le devis n°211216.";
        hashmap["502"] = "Ok le devis a été envoyé.\nVeux-tu le faire signer par votre client ?";
        hashmap["503"] = "Oui utilise la signature électronique.";
        hashmap["504"] = "Ok je soumets le devis à la signature de votre client pour la commande n°211216.";

        
        hashmap["600"] = "";
        hashmap["601"] = "Le niveau de CO2 est trop élevé. Je te conseille d’aérer la pièce.";
        hashmap["602"] = "Ok. Merci.George, désactive le mode notification bien être.";
        hashmap["603"] = "Bien-être désactivé.";
        
        hashmap["700"] = "";
        hashmap["701"] = "Bonjour George, j’ai vu une alerte sur mon tableau de bord\nLe détecteur connecté signale une anomalie.";
        hashmap["702"] = "Bonjour Fred, oui une fuite d’eau a été détectée dans les sanitaires du bureau.\nSouhaites-tu une intervention d’un plombier ?";
        hashmap["703"] = "Oui merci !";
        hashmap["704"] = "Je m’en occupe.";
        
        
        
        ha["100"] = "";
        ha["101"] = "F";
        ha["102"] = "G";
        ha["103"] = "F";
        ha["104"] = "G";
        ha["105"] = "G";
        ha["106"] = "F";
        ha["107"] = "G";
        ha["108"] = "";
        ha["109"] = "G";
        ha["110"] = "G";
        ha["111"] = "G";
        ha["112"] = "F";
        
        
        ha["200"] = "";
        ha["201"] = "F";
        ha["202"] = "G";
        
        ha["300"] = "";
        ha["301"] = "F";
        ha["302"] = "G";
        ha["303"] = "F";
        ha["304"] = "G";
        ha["305"] = "F";
        ha["306"] = "G";
        
        ha["400"] = "";
        ha["401"] = "F";
        ha["402"] = "G";
        ha["403"] = "G";
        
        ha["500"] = "";
        ha["501"] = "F";
        ha["502"] = "G";
        ha["503"] = "F";
        ha["504"] = "G";

        
        ha["600"] = "";
        ha["601"] = "G";
        ha["602"] = "F";
        ha["603"] = "G";
        
        ha["700"] = "";
        ha["701"] = "F";
        ha["702"] = "G";
        ha["703"] = "G";
        ha["704"] = "G";
        /*
        hashmap["11"] = "Bonjour COTE PRO, quelles sont les nouvelles du matin?";
        hashmap["12"] = "Non merci. Rappelle le moi plus tard s’il te plait.";
        hashmap["13"] = "COTE PRO, Avant de partir, peux-tu me dire où en est l’envoi de mon colis envoyé hier ?";
        hashmap["14"] = "Génial, COTE PRO, peux-tu me conseiller le meilleur moyen de m’y rendre ?";
        hashmap["15"] = "Parfait, merci, à tout à l’heure.";
        hashmap["21"] = "COTE PRO, j’ai besoin de d‘être tranquille et de rester au calme. Bascule tous mes appels vers le secrétariat ?";
        hashmap["31"] = "COTE PRO, peux-tu prévenir le facteur qu’il doit venir prendre un colis ? J’ai un colis à retourner.";
        hashmap["32"] = "Ok";
        hashmap["41"] = "COTE PRO peux-tu informer mes clients les plus fidèles pour le show room nocturne de jeudi ?";
        hashmap["51"] = "COTE PRO, peux-tu envoyer les devis pour Madame Lacourt et Monsieur Carilla ?";
        hashmap["52"] = "Tu peux utiliser ma signature électronique \n Code 5219";
        hashmap["53"] = "Tu peux également signer les 2 et lui renvoyer.";
        hashmap["54"] = "Merci.";
        hashmap["61"] = "Ok. Merci. COTE PRO, désactive le mode notification bien être.";
        
        
        hashmap["115"] = "Bonjour Fred, tu as 5 nouveaux messages. Souhaites-tu les écouter ?";
        hashmap["125"] = "D’accord.";
        hashmap["135"] = "Il est arrivé à destination ! \n Tu as 5 rendez-vous dans la journée. Le 1er chez ton comptable Monsieur Lombard à 11h30 rue Lourmel dans le 15ème.";
        hashmap["145"] = "Il y a du trafic sur la route, je te conseille les transports en commun. Tu peux prendre la ligne 6 à Corvisart et descendre à BirHakeim. Et tu peux partir dans 5 minutes. Tu auras 10 minutes de marche à la sortie du métro pour te rendre rue Lourmel. Avec ce trajet tu feras 8% de ton nombre de pas journaliers conseillé. Pense à prendre ton parapluie, il risque de pleuvoir.";
        hashmap["155"] = "";
        hashmap["215"] = "Très bien, tous vos appels sont maintenant basculés.";
        hashmap["315"] = "Demande transmise. Le facteur passera récupérer le colis demain entre 10h et midi, cela vous convient?";
        hashmap["325"] = "La demande est donc confirmée";
        hashmap["415"] = "Ok…163 SMS et 234 mails ont été envoyés à vos clients fidèles.";
        hashmap["515"] = "Il manque une signature sur celui de Monsieur Carilla.";
        hashmap["525"] = "Tu as également reçus 2 contrats du comptable à signer.";
        hashmap["535"] = "Ok c’est fait.";
        hashmap["545"] = "";
        hashmap["615"] = "Le niveau de CO2 est trop élevé. Je vous conseille d’aérer la pièce.";
        hashmap["615"] = "Bien être désactivé.";*/
     
    }
 

}
