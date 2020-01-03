//
//  main.swift
//  AirPodsPair
//
//  Created by Joe Manto on 1/3/20.
//  Copyright © 2020 Joe Manto. All rights reserved.
//
import Foundation
import IOBluetooth

let pairedDevices = IOBluetoothDevice.pairedDevices()!

let arguments = CommandLine.arguments

func match(targetName:String,deviceName:String) -> Bool {
    
    let target:NSString = targetName.lowercased() as NSString
    let device:NSString = deviceName.lowercased() as NSString
    
    var set:Set<UniChar> = Set<UniChar>.init()
    var count = 0
    
    for i in 0...target.length - 1 {
        set.insert(target.character(at: i))
    }
    
    for i in 0...device.length - 1 {
        if(set.contains(device.character(at:i))){
            count+=1
        }
    }
    
    return count > target.length
}

func search(for deviceName:String,_ isRecentDevice:Bool = true) -> IOBluetoothDevice? {
    for i in 0...pairedDevices.count-1 {
        let device = pairedDevices[i] as? IOBluetoothDevice
        
        if(device?.name == deviceName || (!isRecentDevice && match(targetName: deviceName, deviceName: (device?.name)!)) ){
            
            if(!isRecentDevice){setDefaultDevice(deviceName: device?.name)}
            print("... Found \(device?.name ?? "but, the device has no name 🤷🏼‍♂️")")
            return device
        }
    }
    return nil
}

func pair(device:IOBluetoothDevice) -> Bool {
    
    print("... Attempting to pair to \(device.name as String)")
    
    //device is already connected
    if(device.isConnected())
    {
        print("... \(device.name as String) are already paired")
        return true
    }
    
    //attempt to pair device
    if(device.openConnection() == KERN_SUCCESS){
        print("✅ Airpods Connected")
        return true
    }
    
    return false
}

func setDefaultDevice(deviceName:String!) -> Void {
    UserDefaults.standard.set(deviceName, forKey: "targetDevice")
}
func getDefaultDevice() -> String? {
    return UserDefaults.standard.string(forKey: "targetDevice")
}

func flushDefaultDevice() -> Void {
    UserDefaults.standard.set(nil,forKey: "targetDevice")
}

func main(){
    var deviceName:String?
    let tarDevice:IOBluetoothDevice?
    var isRecentDevice = true

    //Flush Option - Removes the default device
    if(arguments.count > 1 && arguments[1] == "-f"){
        flushDefaultDevice()
        return
    }
    
    if let defaultDevice = getDefaultDevice() {
        guard arguments.count != 1 else {
            print("Please enter the bluetooth name of your airpods for the first connection \n\n\t ex. \("pods joes-airpods") ")
            return
        }
        deviceName = defaultDevice
    }
    
    if arguments.count > 1 {
        deviceName = arguments[1]
        isRecentDevice = false
    }
    
    if(deviceName == nil){
        print("Please enter the bluetooth name of your airpods for the first connection \n\n\t ex. \("pods joes-airpods") ")
        return
    }
    
    tarDevice = search(for:deviceName!,isRecentDevice)
    
    if(tarDevice != nil){
        if(!pair(device: tarDevice!)){
            print("bluetooth pairing timed out - your pods may be out of range or dead ❗️")
        }else{
            
        }
    }else{
        print("Device was not found")
    }
}

main()










