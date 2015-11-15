# RappleProgressHUD

[![CI Status](http://img.shields.io/travis/Rajeev Prasad/RappleProgressHUD.svg?style=flat)](https://travis-ci.org/Rajeev Prasad/RappleProgressHUD)
[![Version](https://img.shields.io/cocoapods/v/RappleProgressHUD.svg?style=flat)](http://cocoapods.org/pods/RappleProgressHUD)
[![License](https://img.shields.io/cocoapods/l/RappleProgressHUD.svg?style=flat)](http://cocoapods.org/pods/RappleProgressHUD)
[![Platform](https://img.shields.io/cocoapods/p/RappleProgressHUD.svg?style=flat)](http://cocoapods.org/pods/RappleProgressHUD)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

RappleProgressHUD is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

## Usage

```ruby
pod "RappleProgressHUD"
```

##Usage
import progress library

```ruby
import RappleProgressHUD
```

to start progress indicator

```ruby
RappleActivityIndicatorView.startAnimating()
```

or

```ruby
RappleActivityIndicatorView.startAnimatingWithLabel("Loading...");
```

to stop progress indicator
```ruby
RappleActivityIndicatorView.stopAnimating()
```

###Demo
![demo](Example/Demo/demo.gif)

## Author

Rajeev Prasad, rjeprasad@gmail.com

## License

RappleProgressHUD is available under the MIT license. See the LICENSE file for more info.
