//
//  ViewController.swift
//  CESAuroreIphoneDemo
//
//  Created by Quentin Gras on 16/11/2016.
//  Copyright © 2016 Quentin Gras. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import CoreBluetooth

class ViewController: JSQMessagesViewController  , CBCentralManagerDelegate, CBPeripheralDelegate{

    
    var characteristicNot:CBCharacteristic?;
    var characteristicRead:CBCharacteristic?;
    var peripheralManager:CBPeripheral?;
    var centralManager:CBCentralManager?;
    var messages = [JSQMessage]()
    let defaults = UserDefaults.standard
    var conversation: Conversation?
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    var hashmap: [String: String] = [:];
    var ha: [String: String] = [:];

    fileprivate var displayName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initHash()
        centralManager = CBCentralManager.init(delegate: self, queue: nil);

        // Setup navigation
        setupBackButton()
        
        incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray() )
        outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    

        collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
       
       
        
        
        
        // Show Button to simulate incoming messages
        self.navigationItem.title = "George"
      //  self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.jsq_defaultTypingIndicator(), style: .plain, target: self, action: #selector(receiveMessagePressed))
        
        // This is a beta feature that mostly works but to make things more stable it is diabled.
        collectionView?.collectionViewLayout.springinessEnabled = true
        
        automaticallyScrollsToMostRecentMessage = true
        
        self.collectionView?.reloadData()
        self.collectionView?.layoutIfNeeded()
    }
    
    func setupBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    func backButtonTapped() {
       // dismiss(animated: true, completion: nil)
    }
    
    func receiveMessagePressed(_ sender: UIBarButtonItem) {
        /**
         *  DEMO ONLY
         *
         *  The following is simply to simulate received messages for the demo.
         *  Do not actually do this.
         */
        
        /**
         *  Show the typing indicator to be shown
         */
        self.showTypingIndicator = !self.showTypingIndicator
        
        /**
         *  Scroll to actually view the indicator
         */
        self.scrollToBottom(animated: true)
        
        /**
         *  Copy last sent message, this will be the new "received" message
         */
        var copyMessage = self.messages.last?.copy()
        
        if (copyMessage == nil) {
            copyMessage = JSQMessage(senderId: "1", displayName: "Cote pro", text: "First received!")
        }
        
        var newMessage:JSQMessage!
    

            newMessage = JSQMessage(senderId: "1", displayName: "Cote pro", text: (copyMessage! as AnyObject).text)
        
        
        self.messages.append(newMessage)
        self.finishReceivingMessage(animated: true)
        let message = JSQMessage(senderId: "2" , senderDisplayName: "Fred", date: NSDate() as Date, text: "Hey")
        self.messages.append(message)
        self.finishSendingMessage(animated: true)
    }
    
    // MARK: JSQMessagesViewController method overrides
    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
 
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(message)
        self.finishSendingMessage(animated: true)
    }
    
    //MARK: JSQMessages CollectionView DataSource
    
    override func senderId() -> String {
        return "2"
    }
    
    override func senderDisplayName() -> String {
        return "Fred"
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource {
        
        return messages[indexPath.item].senderId == self.senderId() ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForCellTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        /**
         *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
         *  The other label text delegate methods should follow a similar pattern.
         *
         *  Show a timestamp for every 3rd message
         */
        if (indexPath.item % 7 == 0) {
            let message = self.messages[indexPath.item]
            
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        }
        
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        let message = messages[indexPath.item]
        
        // Displaying names above messages
        //Mark: Removing Sender Display Name
        /**
         *  Example on showing or removing senderDisplayName based on user settings.
         *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
         */
    
        
        if message.senderId == self.senderId() {
            return nil
        }
        
        return NSAttributedString(string: message.senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForCellTopLabelAt indexPath: IndexPath) -> CGFloat {
        /**
         *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
         */
        
        /**
         *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
         *  The other label height delegate methods should follow similarly
         *
         *  Show a timestamp for every 3rd message
         */
        if indexPath.item % 7 == 0 {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        
        return 0.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        
        if message.senderId == "2" {
            cell.textView?.textColor = UIColor.white
        } else {
            cell.textView?.textColor = UIColor.black
        }
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAt indexPath: IndexPath) -> CGFloat {
        
        /**
         *  Example on showing or removing senderDisplayName based on user settings.
         *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
         */

        /**
         *  iOS7-style sender name labels
         */
        let currentMessage = self.messages[indexPath.item]
        
        if currentMessage.senderId == self.senderId() {
            return 0.0
        }
        
        if indexPath.item - 1 > 0 {
            let previousMessage = self.messages[indexPath.item - 1]
            if previousMessage.senderId == currentMessage.senderId {
                return 0.0
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    


     override func didPressAccessoryButton(_ sender: UIButton) {
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
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral){
        // peripheralManager = peripheral;
        peripheralManager?.delegate = self;
        peripheralManager?.discoverServices(nil);
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDisconnectPeripheral peripheral: CBPeripheral,
                        error: Error?){
        central.scanForPeripherals(withServices: [CBUUID.init(string: "A6CD6F10-8710-4695-A915-6DF8727E0F55")], options: [CBCentralManagerScanOptionAllowDuplicatesKey : false]);
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
                print("read ok ");
                
            }
            if ( char.uuid.description == "E876FC49-77FE-42AC-A53A-90F9D3F9FC44"){
                characteristicNot = char;
                
                peripheral.setNotifyValue(true, for: characteristicNot!);
            }
            
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        if (central.state == .poweredOn) {
            central.scanForPeripherals(withServices: [CBUUID.init(string: "A6CD6F10-8710-4695-A915-6DF8727E0F55")], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true]);
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
        print("Notify");
   
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        var str = "";
        
        for x in characteristic.value!{
            str.append(Character(UnicodeScalar(x)));
        }
        NSLog(str);
     
    
        
        if (ha[str] == "F"){
            let message = JSQMessage(senderId: "2" , senderDisplayName: "Fred", date: NSDate() as Date, text:hashmap[str]!)
            self.messages.append(message)
            self.finishSendingMessage(animated: true)

        }
        else if(ha[str] == "G"){
            self.showTypingIndicator = !self.showTypingIndicator
            self.scrollToBottom(animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                
                
                let newMessage = JSQMessage(senderId: "1", displayName: "Cote pro", text: self.hashmap[str]!)
                
                self.messages.append(newMessage)
                self.finishReceivingMessage(animated: true)
            })
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
        hashmap["704"] = "Je planifie un rendez vous pour intervention";
        
        
        
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
        ha["703"] = "F";
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
        hashmap["52"] = "Tu peux utiliser ma signature électronique\nCode 5219";
        hashmap["53"] = "Tu peux également signer les 2 et lui renvoyer.";
        hashmap["54"] = "Merci.";
        hashmap["61"] = "Ok. Merci. COTE PRO, désactive le mode notification bien être.";
        
        
        hashmap["115"] = "Bonjour Fred, tu as 5 nouveaux messages. Souhaites-tu les écouter ?";
        hashmap["125"] = "D’accord.";
        hashmap["135"] = "Il est arrivé à destination !";
        hashmap["136"] = "Tu as 5 rendez-vous dans la journée. Le 1er chez ton comptable Monsieur Lombard à 11h30 rue Lourmel dans le 15ème."
        hashmap["145"] = "Il y a du trafic sur la route, je te conseille les transports en commun. Tu peux prendre la ligne 6 à Corvisart et descendre à BirHakeim. Et tu peux partir dans 5 minutes..";
        hashmap["146"] = "Tu auras 10 minutes de marche à la sortie du métro pour te rendre rue Lourmel. Avec ce trajet tu feras 8% de ton nombre de pas journaliers conseillé"
        hashmap["147"] = "Pense à prendre ton parapluie, il risque de pleuvoir."
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

