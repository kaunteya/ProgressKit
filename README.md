
![Image](/Images/banner.gif)


# Contents
- [Installation](#installation)
- [Usage](#usage)
- [Indeterminate Progress](#indeterminate-progress)
  - [CircularSnail](#circularsnail)
  - [Crawler](#crawler)
  - [Spinner](#spinner)
- [Determinate Progress](#determinate-progress)
  - [Circular Progress] (#circular-progress)
  - [Progress Bar](#progress-bar)
- [License](#license)

# Installation
##CocoaPods
[CocoaPods 0.36](http://cocoapods.org) adds supports for Swift and embedded frameworks.

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
- Change the Class to any of the desired progress Views
- Set the size such that width and height are equal
- Drag `IBOutlet` to View Controller
- For `Indeterminate` Progress Views
  - Set `Boolean` value to `view.animate`
- For `Determinate` Progress Views:
  - Set `view.progress` to value in `0...1`
  

# Indeterminate Progress

![Indeterminate](/Images/indeterminate.gif)  
Progress indicators which animate indefinately are `Indeterminate Progress` Views.

This are the InDeterminate Progress Indicators.


## CircularSnail
![CircularSnail](/Images/CircularSnail.gif)

## Crawler
![Crawler](/Images/Crawler.gif)

## Spinner
![Spinner](/Images/Spinner.gif)

# Determinate Progress
Determinate progress views can be used for tasks whos progress can be seen and determined gradually.

## Circular Progress
![Circular Progress](/Images/CircularProgress.png)

## Progress Bar
![Progress Bar](/Images/ProgressBar.png)

# License
`ProgressKit` is released under the MIT license. See LICENSE for details.

