
![Image](/Images/banner.gif)

`ProgressKit` has set of cool `IBDesignable` progress views, with huge customisation options. 
You can now make spinners, progress bar, crawlers etc, which can be finely customised according to your app palette.

# Contents
- [Installation](#installation)
- [Usage](#usage)
- [Indeterminate Progress](#indeterminate-progress)
  - [CircularSnail](#circularsnail)
  - [Rainbow](#rainbow)
  - [Crawler](#crawler)
  - [Spinner](#spinner)
  - [Shooting Stars](#shooting-stars)
  - [Rotating Arc](#rotating-arc)
- [Determinate Progress](#determinate-progress)
  - [Circular Progress] (#circular-progress)
  - [Progress Bar](#progress-bar)
- [License](#license)

# Installation
##CocoaPods
[CocoaPods](http://cocoapods.org) adds supports for Swift and embedded frameworks.

To integrate ProgressKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'ProgressKit'
```

Then, run the following command:

```bash
$ pod install
```
  
# Usage
- Drag  a View at desired location in `XIB` or `Storyboard`
- Change the Class to any of the desired progress views
- Set the size such that width and height are equal
- Drag `IBOutlet` to View Controller
- For `Indeterminate` Progress Views
  - Set `true / false` to `view.animate`
- For `Determinate` Progress Views:
  - Set `view.progress` to value in `0...1`
  

# Indeterminate Progress

![Indeterminate](/Images/indeterminate.gif)  
Progress indicators which animate indefinately are `Indeterminate Progress` Views.

This are the set of Indeterminate Progress Indicators.

## CircularSnail
![CircularSnail](/Images/CircularSnail.gif)

## Rainbow
![Rainbow](/Images/Rainbow.gif)
## Crawler
![Crawler](/Images/Crawler.gif)

## Spinner
![Spinner](/Images/Spinner.gif)

## Shooting Stars
![Shooting Stars](/Images/ShootingStars.gif)

## Rotating Arc
![Rotating Arc](/Images/RotatingArc.gif)

# Determinate Progress
Determinate progress views can be used for tasks whos progress can be seen and determined.

## Circular Progress
![Circular Progress](/Images/CircularProgress.png)

## Progress Bar
![Progress Bar](/Images/ProgressBar.png)

# License
`ProgressKit` is released under the MIT license. See LICENSE for details.

