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

        scanner = LANScanner(delegate: self, continuous: false)
        scanner?.startScan()
        print("Starting scan")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.devices.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scanCell", forIndexPath: indexPath)
        let device = self.devices[indexPath.row]
        
        cell.textLabel?.text = device.hostName
        cell.detailTextLabel?.text = device.ipAddress
        
        return cell
    }
    
    // MARK - IBActions
    @IBAction func restart() {
        
        self.scanner?.stopScan()
        self.scanner?.startScan()
    }
    
    
    // MARK - LANScanner Delegate
    func LANScannerDiscovery(device: LANDevice) {
        
        self.devices.append(device)
        self.tableView.reloadData()
    }
    
    func LANScannerFailed(error: NSError) {
        print("Unable to scan: \(error)")
    }
    
    func LANScannerFinished() {
        print("Finished scanning")
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
