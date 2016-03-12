# TableViewDataManager

[![Version](https://img.shields.io/cocoapods/v/TableViewDataManager.svg?style=flat)](http://cocoapods.org/pods/TableViewDataManager)
[![License](https://img.shields.io/cocoapods/l/TableViewDataManager.svg?style=flat)](http://cocoapods.org/pods/TableViewDataManager)
[![Platform](https://img.shields.io/cocoapods/p/TableViewDataManager.svg?style=flat)](http://cocoapods.org/pods/TableViewDataManager)

__Powerful data driven content manager for UITableView written in Swift.__

`TableViewDataManager` allows to manage the content of any `UITableView` with ease, both forms and lists. `TableViewDataManager` is built on top of reusable cells technique and provides APIs for mapping any object class to any custom cell subclass.

The general idea is to allow developers to use their own `UITableView` and `UITableViewController` instances (and even subclasses), providing a layer that synchronizes data with the cell appereance.
It fully implements `UITableViewDelegate` and `UITableViewDataSource` protocols so you don't have to.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* iOS 8.0+
* Swift 2.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build TableViewDataManager.

To integrate TableViewDataManager into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'TableViewDataManager'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate TableViewDataManager into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "TableViewDataManager/TableViewDataManager" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `TableViewDataManager.framework` into your Xcode project.

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate TableViewDataManager into your project manually.

## Author

Roman Efimov

- https://github.com/romaonthego
- https://twitter.com/romaonthego
- romefimov@gmail.com

## License

TableViewDataManager is available under the MIT license. See the LICENSE file for more info.
