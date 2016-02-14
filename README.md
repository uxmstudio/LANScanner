# LANScanner

[![Version](https://img.shields.io/cocoapods/v/LANScanner.svg?style=flat)](http://cocoapods.org/pods/LANScanner)
[![License](https://img.shields.io/cocoapods/l/LANScanner.svg?style=flat)](http://cocoapods.org/pods/LANScanner)
[![Platform](https://img.shields.io/cocoapods/p/LANScanner.svg?style=flat)](http://cocoapods.org/pods/LANScanner)

Easily scan a Wi-Fi network for devices

# Installation
## CocoaPods
LANScanner is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LANScanner"
```

# Usage
## Start a scan
```swift
let scanner = LANScanner(delegate: self, continuous: false)
scanner?.startScan()
```
Be sure to implement the delegate LANScannerDelegate

## Get IP address of local device
```swift
var netInfo = LANScanner.getLocalAddress()
print(netInfo.ip)
print(netInfo.netmask)
```

## Interface
```swift

/// Public
var delegate:LANScannerDelegate // Delegate for discovery callbacks
var continuous:Bool // When set this will restart the scan when completed

func startScan() // Begin a scan
func stopScan() // End a scan

static func getHostName(ipaddress: String) -> String? // Get the hostname from an IP address
static func getLocalAddress() -> NetInfo? // Get the local devices IP address and 

/// Delegate
func LANScannerDiscovery(device: LANDevice)
func LANScannerFinished()    
func LANScannerRestarted()
func LANScannerFailed(error: NSError)  
```

# Author
Chris Anderson:
- chris@uxmstudio.com
- [Home Page](http://uxmstudio.com)

# License

LANScanner is available under the MIT license. See the LICENSE file for more info.