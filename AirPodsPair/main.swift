//
//  main.swift
//  AirPodsPair
//
//  Created by Joe Manto on 1/3/20.
//  Copyright © 2020 Joe Manto. All rights reserved.
//

import Foundation
import IOBluetooth


let deviceName = "Joe’s AirPods"
let pairedDevices = IOBluetoothDevice.pairedDevices()!

func search(for deviceName:String) -> IOBluetoothDevice? {
    for i in 0...pairedDevices.count-1 {
        print("Paired Device \(i)")
        let device = pairedDevices[i] as? IOBluetoothDevice
        
        if(device?.name == deviceName){
            print("Found Device \(device?.name ?? "Device has no name")")
            return device
        }
    }
    return nil
}

func pair(device:IOBluetoothDevice!) -> Bool {
    
    //device is already connected
    if(device.isConnected())
    {
        return true
    }
    
    //attempt to pair device
    if(device.openConnection() == KERN_SUCCESS){
        print("connectioned to device")
        return true
    }
    
    return false
   
}

var tarDevice:IOBluetoothDevice? = search(for:deviceName)

if(tarDevice != nil){
    let res = pair(device: tarDevice)
}











