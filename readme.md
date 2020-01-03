# AirPodsPair
> swift executable or command line tool that can be used in the ternmal or in automation tasks that will attempt to make a bluetooth connection to your airpods.

Main useage is switching from the Iphone connection to your laptop

## Usage
``$ pods <substring of airpods display name>`` **or** `pods`
##### On First Connection
`$ pods <substring of airpods display name>`

ex. `$ pods joes`
##### Using Default Saved Device
`$ pods`

AirPodsPair will connect to last device that has been paired. AirPodsPair uses UserDefaults to save the last known airpods display name that has been paired successfully in the past and if no arguments are given.

## Other Possible Use Cases
* Can be used inside Automator
    * Automatically connect your airpods when Spotify is opened 
* Can be used in in Apple-Scripts

## Installation 

clone the project and place the `pods` executable in `/usr/local/bin` and your off 🚀

