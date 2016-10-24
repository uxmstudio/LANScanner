//
//  SimplePingHelper.swift
//  Pods
//
//  Created by Chris Anderson on 2/14/16.
//
//

import UIKit

class SimplePingHelper: NSObject, SimplePingDelegate {
    
    fileprivate var address:String
    fileprivate var simplePing:SimplePing?
    fileprivate var target:AnyObject
    fileprivate var selector:Selector
    
    static func start(_ address:String, target:AnyObject, selector:Selector) {
        
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
        self.perform(#selector(SimplePingHelper.endTime), with: nil, afterDelay: 1)
    }
    
    
    // MARK: - Helper Methods
    func killPing() {
        self.simplePing?.stop()
        self.simplePing = nil
    }
    
    func successPing() {
        self.killPing()
        let _ = self.target.perform(self.selector, with: [
            "status": true,
            "address": self.address
            ])
    }
    
    func failPing(_ reason: String) {
        
        self.killPing()
        let _ = self.target.perform(self.selector, with: [
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
    func simplePing(_ pinger: SimplePing!, didStartWithAddress address: Data!) {
        self.simplePing?.send(with: nil)
    }
    
    func simplePing(_ pinger: SimplePing!, didFailWithError error: Error!) {
        self.failPing("didFailWithError")
    }
    
    func simplePing(_ pinger: SimplePing!, didFailToSendPacket packet: Data!, error: Error!) {
        self.failPing("didFailToSendPacked")
    }
    
    func simplePing(_ pinger: SimplePing!, didReceivePingResponsePacket packet: Data!) {
        self.successPing()
    }
    
}
