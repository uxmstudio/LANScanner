//
//  SimplePingHelper.swift
//  Pods
//
//  Created by Chris Anderson on 2/14/16.
//
//

import UIKit

class SimplePingHelper: NSObject, SimplePingDelegate {
    
    private var address:String
    private var simplePing:SimplePing?
    private var target:AnyObject
    private var selector:Selector
    
    static func start(address:String, target:AnyObject, selector:Selector) {
        
        SimplePingHelper(address: address, target: target, selector: selector).start()
    }
    
    init(address: String, target:AnyObject, selector:Selector) {
        
        self.simplePing = SimplePing(hostName:address)
        
        self.target = target
        self.selector = selector
        self.address = address
        
        super.init()
        
        self.simplePing!.delegate = self
    }
    
    func start() {
        
        self.simplePing?.start()
        self.performSelector(#selector(SimplePingHelper.endTime), withObject: nil, afterDelay: 1)
    }
    
    
    // MARK: - Helper Methods
    func killPing() {
        self.simplePing?.stop()
        self.simplePing = nil
    }
    
    func successPing() {
        self.killPing()
        self.target.performSelector(self.selector, withObject: [
            "status": true,
            "address": self.address
            ])
    }
    
    func failPing(reason: String) {
        
        self.killPing()
        self.target.performSelector(self.selector, withObject: [
            "status": false,
            "address": self.address,
            "error": reason
            ])
    }
    
    func endTime() {
        if let _ = self.simplePing {
            self.failPing("timeout")
            return
        }
    }
    
    
    // MARK: - SimplePing Delegate
    func simplePing(pinger: SimplePing!, didStartWithAddress address: NSData!) {
        self.simplePing?.sendPingWithData(nil)
    }
    
    func simplePing(pinger: SimplePing!, didFailWithError error: NSError!) {
        self.failPing("didFailWithError")
    }
    
    func simplePing(pinger: SimplePing!, didFailToSendPacket packet: NSData!, error: NSError!) {
        self.failPing("didFailToSendPacked")
    }
    
    func simplePing(pinger: SimplePing!, didReceivePingResponsePacket packet: NSData!) {
        self.successPing()
    }
    
}
