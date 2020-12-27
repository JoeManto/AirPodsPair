# Pods
> Executable that can be used in the terminal or in automation tasks that will attempt to make a bluetooth connection to your AirPods or really any device :)

AirPods automatically connect to their last connected device. For me that is 9/10 always my iPhone, so this project finds its use cases as an executable for automated tasks or as a nice convenience if you find your self with a terminal open more often than not. 

<p align="center">
<img width = "500" src = "https://raw.githubusercontent.com/joemanto/AirPodsPair/master/res/screenshot.png"/>
</div>

## Usage
##### Using Default Saved Device
`$ pods`

Pods will connect to last device that has been paired. Pods uses UserDefaults to save the last known device display name that has been paired successfully in the past.

##### On First Connection
`$ pods <substring of device display name>`

ex. `$ pods joes`

#### - f 
This will manually flush the last saved device.
This also can be accomplished by over writing the last saved device by providing a display name as an argument. 

`pods -f` **or** `pods xm4`

#### - l
This will list the display name for any active device that as been successfully paired to the system.

## Other Possible Use Cases
* Can be used inside Automator
    * Automatically connect your airpods when Spotify is opened 
* Can be used in AppleScript

## Installation 

clone the project and place the `pods` executable in `/usr/local/bin` and your off 🚀

#### Quick Install Command
Notice: The Pods executable will be moved to your `local/bin` and the **cloned repo will be deleted** 

`git clone https://github.com/JoeManto/AirPodsPair.git && sudo cp AirPodsPair/pods /usr/local/bin && sudo rm -r AirPodsPair`

