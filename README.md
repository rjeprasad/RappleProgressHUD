# RappleProgressHUD

[![Version](https://img.shields.io/cocoapods/v/RappleProgressHUD.svg?style=flat)](http://cocoapods.org/pods/RappleProgressHUD)
[![License](https://img.shields.io/cocoapods/l/RappleProgressHUD.svg?style=flat)](http://cocoapods.org/pods/RappleProgressHUD)
[![Platform](https://img.shields.io/cocoapods/p/RappleProgressHUD.svg?style=flat)](http://cocoapods.org/pods/RappleProgressHUD)


User-friendly and easy to use activity / progress indicator view with Swift 4

[Please use version 2.3.1 for Swift 3 builds]

## Demo

![demo](Example/Demo/progress225.gif)

## Requirements
- Swift 4
- Xcode 9
- iOS 8+

### Please use version 2.3.1 for Swift 3 builds


## Installation
RappleProgressHUD is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

## Usage
```ruby
pod "RappleProgressHUD" 
```

Then simply import RappleProgressHUD 
```ruby
import RappleProgressHUD
```
</BR>

RappleActivityIndicatorView can be started using any of the starter methods mentioned below. 
When calling these starter methods, two basic optional input values can be used to customize UIs.

**`label`** this is the text value you are gonna display with the animated indicator

**`attributes`** this is a dictionary with following Keys.

- `RappleTintColorKey`               Color of the progress circle and text
- `RappleScreenBGColorKey`           Background color (full screen background)
- `RappleProgressBGColorKey`         Background color around the progress indicator (Only applicable for Apple Style)
- `RappleIndicatorStyleKey`          Style of the ActivityIndicator - see below section for styles
- `RappleProgressBarColorKey`        Progress bar bg color - track bg color
- `RappleProgressBarFillColorKey`    Progress bar filling color with progression - filled track color
- `RappleIndicatorThicknessKey`      ActivityIndicator thicknes(width) - applicable for 'RappleStyleCircle' and completion indicators

In above dictionary you can send 'RappleIndicatorStyleKey' with below three styles (see the demo for more details)

- `RappleStyleApple`                Default Apple ActivityIndicator
- `RappleStyleCircle`               Custom Circular ActivityIndicator
- `RappleStyleText`                 Custom Texual ActivityIndicator (e.g. Loading.. | Loading....)


RappleActivityIndicatorView has two pre-defines attribute sets for ease of use

#### `RappleAppleAttributes` Predefined attribute dictionary to match default apple look & feel

- `RappleTintColorKey`               white
- `RappleScreenBGColorKey`           white: 0.0, alpha: 0.2
- `RappleProgressBGColorKey`         white: 0.0, alpha: 0.7
- `RappleIndicatorStyleKey`          RappleStyleApple
- `RappleProgressBarColorKey`        lightGray
- `RappleProgressBarFillColorKey`    white
- `RappleIndicatorThicknessKey`      4.0

#### `RappleModernAttributes`  Predefined attribute dictionary with modern look & feel

- `RappleTintColorKey`               white
- `RappleScreenBGColorKey`           white: 0.0, alpha: 0.5
- `RappleProgressBGColorKey`         N/A
- `RappleIndicatorStyleKey`          RappleStyleCircle
- `RappleProgressBarColorKey`        lightGray
- `RappleProgressBarFillColorKey`    white
- `RappleIndicatorThicknessKey`      4.0

#### `RappleTextAttributes`  Predefined attribute dictionary with modern look & feel

- `RappleTintColorKey`               white
- `RappleScreenBGColorKey`           white: 0.0, alpha: 0.5
- `RappleProgressBGColorKey`         N/A
- `RappleIndicatorStyleKey`          RappleStyleText
- `RappleProgressBarColorKey`        N/A
- `RappleProgressBarFillColorKey`    N/A
- `RappleIndicatorThicknessKey`      4.0

Or you can send any custom made dictionary with these Key values to customize the look and feel

to create custom attribute dictionary you can use below method, and all the parameters of this method comes with default values.

```ruby
let attributes = RappleActivityIndicatorView.attribute(style: RappleStyle.apple, tintColor: .yellow, screenBG: .purple, progressBG: .black, progressBarBG: .orange, progreeBarFill: .red, thickness: 4)

let attributes = RappleActivityIndicatorView.attribute(style: RappleStyle.apple, tintColor: .yellow, progreeBarFill: .red, thickness: 2)

```

#### RappleActivityIndicatorView starter methods

Start RappleActivityIndicatorView using RappleModernAttributes - no text message
```ruby
RappleActivityIndicatorView.startAnimating()
```

Start RappleActivityIndicatorView with custom (or pre-defined) attributes - no text message
```ruby
RappleActivityIndicatorView.startAnimating(attributes: RappleModernAttributes)
```

Start RappleActivityIndicatorView with a text message, using RappleModernAttributes
```ruby
RappleActivityIndicatorView.startAnimatingWithLabel("Processing...")
```

Start RappleActivityIndicatorView with text message and attributes
```ruby
RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleModernAttributes)
```

#### Stop RappleActivityIndicatorView
```ruby
RappleActivityIndicatorView.stopAnimating()
```

RappleActivityIndicatorView can also be closed with completion indicator
```ruby
RappleActivityIndicatorView.stopAnimation(completionIndicator: .success, completionLabel: "Completed.", completionTimeout: 1.0)
```

You can use any of the following RappleCompletion enum values as the indicator
- `none`             Stop and hide animation with out completion indicator
- `success`          ✓ symbol
- `failed`           ✕ symbol
- `incomplete`       ! symbol
- `unknown`          ? symbol

#### Start RappleActivityIndicatorView’s progress value

- progress amount 0<= progress <= 1.0
- textual progress amount value (e.g. `"3/8"` or `"3/10"`) : limited space available
- textValue `nil` will display percentage values (e.g. 78%)
- textValue `""`-> hide textual progress amount
- `RappleStyleApple` will use default apple progress bar
- `RappleStyleCircle` will use circular progress bar
- `RappleStyleText` will not display any progress bar
```ruby
RappleActivityIndicatorView.setProgress(0.2, textValue: "1/5")
```

```ruby
RappleActivityIndicatorView.setProgress(0.2) // Display with percentage value
```

#### How to add progress bar

First start progress bar using any of the starter methods</br>
Then call `setProgress` methods with or without `textValue:` parameter
```ruby
RappleActivityIndicatorView.startAnimatingWithLabel("Processing...")
RappleActivityIndicatorView.setProgress(0.2, textValue: "1/5")
```
Then gradually increase progress values accordingly - can be called from any thread
```ruby
RappleActivityIndicatorView.setProgress(0.4, textValue: "2/5")
```

Check for RappleActivityIndicatorView visiblility
```ruby
RappleActivityIndicatorView.isVisible()
```

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Rajeev Prasad, rjeprasad@gmail.com

## License
The MIT License (MIT)

Copyright (c) 2017 Rajeev Prasad <rjeprasad@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

