//
//  MainViewController.swift
//  HorrorBoard
//
//  Created by Hunter Oppel on 10/26/20.
//

import UIKit
import CoreBluetooth

class MainViewController: UIViewController {

    @IBOutlet var connectedLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!

    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        updateViews()
    }

    private func updateViews() {
    }
    
    @IBAction func attemptToConnectViaBLE(_ sender: Any) {
        if centralManager.state == .poweredOn {
            self.activityIndicator.startAnimating()
            centralManager.scanForPeripherals(withServices: nil)
        } else {
            self.presentSimpleAlert(with: "ERROR", message: "Something is wrong with BLE")
        }
    }
}

extension MainViewController: CBPeripheralDelegate, CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
        @unknown default:
            fatalError()
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.name == "raspberrypi" {
            activityIndicator.stopAnimating()
            print("Found the pi")
            self.peripheral = peripheral
            centralManager.stopScan()
            centralManager.connect(self.peripheral)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        connectedLabel.text = "Connected!"
    }
}
