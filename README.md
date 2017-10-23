# DJIDemoKit

## Introducation

`DJIDemoKit` is used to reduce timing wasting on your demo work. You can directly use `DJIDemoKit` to:

* [x] Connect to DJI Device;
* [x] Check and handle activation stuff;
* [x] Check and handle aircraft binding stuff;
* [x] Config remote log server info;
* [x] Config to use bridge mode to connect devices;

![image](./_readme_resource/start_up.png)

In the comming future, `DJIDemoKit` can even simply the progress of project configuration, which is requested by DJISDK, so you will not meet some wierd bug because of forgetting some configuration :D

## Installation

Insert dependency below to your podfile:

```
pod 'DJIDemoKit'
```

Then run command below in console at your working directory:

```
pod install
```

Your may see:

```
Installing DJI-SDK-iOS (4.3.2)
Installing DJIDemoKit 0.1 (was 0.1)
Installing SnapKit (3.2.0)
```

Yes, `DJIDemoKit` depends on `SnapKit` and `DJISDK`.

## Project configuration

### 0X01

Set your project's swift version to **4.0**

> That is because `DJIDemoKit` dependents on `DJISDK` and `SnapKit`, and `SnapKit` does not support swift 4.X so far.

### 0x02

Remove `DJISDK` and `SnapKit` from your podfile if they exist.

> As mentioning before, `DJIDemoKit` has dependences on `DJISDK` and `SnapKit`. When you install `DJIDemoKit`, this two pod will be installed in the same time.

### 0x03

Add `Supported external accessory protocols` item in your project's `info.plist` file. This is required by DJISDK.

![image](./_readme_resource/external_access.png)

### 0X04

Disable bitcode setting in your project, for **DJI-SDK-iOS** not containing bitcode.

![image](./_readme_resource/bitcode.png)

### 0X05

Finally, don't forget to set your `DJISDKAppKey` in your `info.plist` file.

## Usage

### 0x01 DDKStartViewController

The `DDKStartViewController` is the controller that the screen shot shows to you. When device is connected, the tableview will display the infos of device, also you can proceed activation stuff here.

Besides, you can config your remote log server info and bridger app ip here.

To use `DDKStartViewController`, just simply:

```
import DJIDemoKit

...
let viewCon = DDKStartViewController()
viewCon.delegate = myDelegate
...
```

### 0x02 DDKRCViewController

The `DDKRCViewController` will show you the joysticks' value on its view:

![image](./_readme_resource/rc_view_controller.png)

To use `DDKRCViewController`:

```
let viewCon = DDKRCViewController()
self.present(viewCon, animated: true, completion: nil)
```

The view controller will make itself to be the delegate of `DJIRemoteController`, and get data from delegate methods.

### 0x03 DDKLogger

The `DDKLogger` can let you log something to console with some preconfig style. And if you enable **remote logging mode**, `DDKLogger` will log info to console and your remote log server.

```
ddkLog("...")
ddkLogOK("...")
ddkLogInfo("...")
ddkLogError("...")
ddkLogWarning("...")
```

### 0x04 DDKConfig

`DDKConfig` contains all configuration info that you did in `StartupViewController`:

```
let isBridgerEnable = DDKConfig.default.enableBridger
```

You can dig into this project to discover other minor modules.

## To do

* [ ] Create a script to config the project automatically.
* [ ] Add `VideoPreviewerController` and make it be in common use.

## Contribution

If you want to add some other component like `VideoPreviewerController` or some other debug configuration, just feel free to let me know by **creating issues**. Or you can contribute your code through **pull rquest**.

Respect.
