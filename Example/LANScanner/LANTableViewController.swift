//
//  LANTableViewController.swift
//  LANScanner
//
//  Created by Chris Anderson on 2/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import LANScanner

class LANTableViewController: UITableViewController, LANScannerDelegate {

    var devices:[LANDevice] = []
    var scanner:LANScanner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Scanning"

        scanner = LANScanner(delegate: self, continuous: false)
        scanner?.startScan()
        print("Starting scan")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.devices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scanCell", for: indexPath)
        let device = self.devices[indexPath.row]
        
        cell.textLabel?.text = device.hostName
        cell.detailTextLabel?.text = device.ipAddress
        
        return cell
    }
    
    // MARK - IBActions
    @IBAction func restart() {
        
        self.title = "Scanning"
        
        self.devices.removeAll()
        self.tableView.reloadData()
        
        self.scanner?.stopScan()
        self.scanner?.startScan()
    }
    
    
    // MARK - LANScanner Delegate
    func LANScannerDiscovery(_ device: LANDevice) {
        
        self.devices.append(device)
        self.tableView.reloadData()
    }
    
    func LANScannerFailed(_ error: NSError) {
        
        print("Unable to scan: \(error)")
    }
    
    func LANScannerFinished() {
        
        print("Finished scanning")
        self.title = "Finished Scanning"
    }
    
    func LANScannerRestarted() {
        
        print("Restarted scanning")
        self.devices = []
        self.tableView.reloadData()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
