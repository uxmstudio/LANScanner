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

## Interface
```swift

/// Public
var continuous:Bool // When set this will restart the scan when completed

func startScan() // Begin a scan
func stopScan() // End a scan


/// Delegate
func LANScannerDiscovery(device: LANDevice)
func LANScannerFinished()    
func LANScannerFailed(error: NSError)  
```

# Author
Chris Anderson:
- chris@uxmstudio.com
- [Home Page](http://uxmstudio.com)

# License

LANScanner is available under the MIT license. See the LICENSE file for more info.