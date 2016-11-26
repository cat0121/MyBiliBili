# CSNetManager
## Use

``` bash
Appdelegate
import RealReachability
RealReachability.sharedInstance().startNotifier() //开启网络监控
```


## Requirements

* iOS 8.0+, tvOS 9.0+, watchOS 2.0+ or OS X 10.10+
* Xcode 7.3 or above



## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

``` bash
$ gem install cocoapods
```

To integrate Kingfisher into your Xcode project using CocoaPods, specify it in your `Podfile`:

``` ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'CSNetManager'
```

Then, run the following command:

``` bash
$ pod install
```

You should open the `{Project}.xcworkspace` instead of the `{Project}.xcodeproj` after you installed anything from CocoaPods.

For more information about how to use CocoaPods, I suggest [this tutorial](http://www.raywenderlich.com/64546/introduction-to-cocoapods-2).


## Contact

Follow and contact me on  [Sina Weibo](http://weibo.com/3972041809). If you find an issue, just [open a ticket](https://github.com/lichangsong/CSNetManager/issues/new) on it. Pull requests are warmly welcome as well.

## License

CSNetManager is released under the MIT license. See LICENSE for details.


