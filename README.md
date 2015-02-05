# JBPerformanceLogger
Performance logger suitable for measuring number of frames per second in iOS applications.

![alt tag](https://cloud.githubusercontent.com/assets/2537227/6059233/5bb50b6c-ad2f-11e4-9244-704262d2d910.PNG)

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like JBMessage in your projects. This is recommented way for instalation.

#### Podfile

```ruby
platform :ios, '7.0'
pod 'JBPerformanceLogger'
```
## USAGE
I always wanted to measure performance of UITableView during scroll and I liked way how game engines display FPS number. Hope this will be good replacement for that feature.

Call start to start it. It will automatically appear in key window.

```objective-c
[JBPerformanceLogger start];
```

Call stop to stop it. It will automatically dissappear from key window.

```objective-c
[JBPerformanceLogger stop];
```

You can adjust it's position in window, offset and text color. It uses PureLayout library for adding NSLayoutConstraints and positioning in window.
```objective-c
[JBPerformanceLogger setPosition:JBPerformanceLoggerPositionBottom | setPosition:JBPerformanceLoggerPositionLeft];
[JBPerformanceLogger setTextColor:[UIColor greenColor]];
```

## Issues
Feel free to raise an issue if you find bug or you have some suggestion for improving it.