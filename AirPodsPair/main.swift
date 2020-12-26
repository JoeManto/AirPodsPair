//
//  main.swift
//  AirPodsPair
//
//  Created by Joe Manto on 1/3/20.
//  Copyright © 2020 Joe Manto. All rights reserved.
//
import Foundation
import IOBluetooth

let arguments = CommandLine.arguments
var pairedDevices:[IOBluetoothDevice]!

func setDefaultDevice(deviceName:String!) -> Void {
    UserDefaults.standard.set(deviceName, forKey: "targetDevice")
}

func getDefaultDevice() -> String? {
    return UserDefaults.standard.string(forKey: "targetDevice")
}

func flushDefaultDevice() -> Void {
    UserDefaults.standard.set(nil, forKey: "targetDevice")
}

func match(targetName: inout String, pairedDeviceName: inout String) -> Bool {
    targetName = targetName.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    targetName = targetName.lowercased()
    pairedDeviceName = pairedDeviceName.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    pairedDeviceName = pairedDeviceName.lowercased()
    
    return pairedDeviceName.contains(targetName)
}

func search(for targetName:String) -> IOBluetoothDevice? {
    var target = targetName
    var matches: [IOBluetoothDevice] = []
    
    for i in 0...pairedDevices.count-1 {
        let pairedDevice = pairedDevices[i]
        guard var actual = pairedDevice.name else {
            continue
        }
        
        if actual == target || match(targetName: &target, pairedDeviceName: &actual) {
            setDefaultDevice(deviceName: actual)
            print("... Found \(actual)")
            matches.append(pairedDevice)
        }
    }
    
    if matches.count == 0 {
        return nil
    }
    
    if matches.count > 1 {
        print("Multiple devices found attempting to connect \(matches[0].name as String)")
    }
    
    return matches[0]
}

func connect(_ device:IOBluetoothDevice) -> Bool {
    print("... Attempting to pair to \(device.name as String)")
    
    // Device is already connected
    if(device.isConnected())
    {
        print("... \(device.name as String) - already paired")
        return true
    }
    
    return device.openConnection() == KERN_SUCCESS
}

func listPairedDevices() {
    print("Display Names:")
    pairedDevices.forEach{ device in
        print("-\t\(device.name as String)")
    }
}

func main() {
    var target:String
    
    guard let devices = IOBluetoothDevice.pairedDevices() as? [IOBluetoothDevice],
       devices.count > 0 else {
        print("System has no paired device to connect to")
        return
    }
    pairedDevices = devices

    //Flush Option - Removes the default device
    if(arguments.count > 1 && arguments[1] == "-f"){
        flushDefaultDevice()
        return
    }
    //List Paired Devices
    if(arguments.count > 1 && arguments[1] == "-l"){
        listPairedDevices()
        return
    }
    
    if let defaultDevice = getDefaultDevice(),
       arguments.count == 1 {
        target = defaultDevice
    }
    else if arguments.count > 1 && arguments[1].count > 0 {
        target = arguments[1]
    }
    else {
        print("Please enter a substring of the bluetooth display name of the device you wish to connect \n\n\t ex. \("pods airpods") \n pods -l to list display names")
        return
    }
 
    if let device = search(for: target) {
        if(!connect(device)){
            print("Bluetooth connection timed out - your pods may be out of range or dead ❗️")
        }else{
            print("✅ Connected")
        }
    }else{
        print("Device was not found")
    }
}

main()











