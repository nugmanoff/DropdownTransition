<p align="center">
	<a href="https://github.com/nugmanoff/DropdownTransition/"><img src="Resources/cover-full.png" alt="DropdownTransition width="600" height="220" /></a><br /><br />
</p>
<br />

<p align="center">Simple and elegant dropdown transition for iOS</p>
<p align="center">
    <a href="(https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg"></a>
    <a href="https://cocoapods.org/pods/DropdownTransition"><img src="https://img.shields.io/cocoapods/v/DropdownTransition.svg"></a>
    <a href="https://cocoapods.org/pods/DropdownTransition"><img src="https://img.shields.io/badge/pod%20name-Dropdown-5ba36b.svg"></a>
    <a href="https://cocoapods.org/pods/DropdownTransition"><img src="https://img.shields.io/cocoapods/p/DropdownTransition.svg"></a>
    <a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-support-B160B6.svg"></a>
</p>

## Why?

I needed to perform the dropdown transition in the app I was building and I've found many great libraries out there that provide desired functionality. But all of them had one flaw in them: they were *NOT* implemented as custom transitions, but rather as some view animations.

This library solves this problem by providing you custom modal transition that is implemented using `UIPresentationController` and `UITransitionCoordinator`. It provides you with greater flexibility and is more suitable for the use in projects that follow some standard architecture & navigation patterns (e.g. `Router`, `Navigator` & `Coordinator` patterns)

## Demo
<img src="https://github.com/nugmanoff/DropdownTransition/blob/master/Resources/demo-default.gif" width="400" height="864"/>
 
## Installation
There are multiple options for installing DropdownTransition:

Using **Carthage** dependency manager, add following line to `Cartfile`:
```shell
github "nugmanoff/DropdownTransition" ~> 1.0.0
```

Using **CocoaPods** add following line to your project `Podfile`:
```shell
pod 'DropdownTransition', '~> 1.0.0'
```

Using **Swift Package Manager**, add the following line to your `Package.swift`:
```swift
dependencies: [
  .package(url: "https://github.com/nugmanoff/DropdownTransition.git", .exact("1.0.0")),
]
```
Or just simply drag `*.swift` files from `DropdownTransition` folder to your project (my favorite option).

## Usage

1. You need to conform to `DropdownPresentable` protocol in the `UIViewController` subclass you wish to present.
```swift
class SomeViewController: UIViewController, DropdownPresentable {
    // ...
}
```
2. You need to store instance variable of `DropdownTransitioningDelegate` somewhere accessible form your call to `present` method (e.g. in `Coordinator` pattern that'd be inside `Router` implementation)
```swift
let dropdownTransitioningDelegate = DropdownTransitioningDelegate()`
```
3. As the final step, you need to perform the actual transition by assigning the tweaking the options of view controller that is going to be presented, and calling the `present` function with it.
```swift
let someViewController = SomeViewController()
someViewController.transitioningDelegate = dropdownTransitioningDelegate
someViewController.modalPresentationStyle = .custom
navigationController?.present(someViewController, animated: true, completion: nil)
```
If you are using Auto Layout and wondering how to present controller with the proper height, take a look at the [Pro tip](#pro-tip)

### Advanced usage

In order to customize various presentation parameters, you need to override implement needed variables from `DropdownPresentable` protocol, otherwise their values will be set to some sensible defaults.
```swift
var isDraggingEnabled: Bool { get } // option that indicates whether you can drag (pan gesture) the dropdown controller or not
var dismissAfterRelease: Bool { get } // when enabled automatically dismisses controller when it surpasses threshold value
var dismissDraggingTranslationThreshold: CGFloat { get } // threshold value for dismissals
var stretchableBackgroundColor: UIColor { get } // background color of the view that stretches at the top of the controller (if dragging is enabled)
var dismissAfterTappingDimmingView: Bool { get } // when enabled automatically dismisses controller upon tap on the dimmed (black) area
var isFeedbackEnabled: Bool { get } // whether or not haptic feedback is generated on reaching threshold value
var feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle { get } // haptic feedback style
```
<img src="https://github.com/nugmanoff/DropdownTransition/blob/master/Resources/demo-nondraggable.gif" width="400" height="864"/>

Demo above shows the presented controller with `dismissAfterRelease` set to `false`, as you see controller is not dismissed automatically as opposed to the default state shown in the first demo.

### Pro tip

Intrinsic height of the presented `UIViewController` needs to be set correctly in order to attain the desired height and behavior of the transition.
Luckily you can do that easily by calling this function in `viewDidLayoutSubviews` and `viewDidLoad` methods of the `UIViewController`

```swift
private func updatePreferredContentSize() {
        view.updateConstraintsIfNeeded()
        let viewSize = CGSize(width: UIScreen.main.bounds.width, height: .leastNonzeroMagnitude)
        preferredContentSize = view.systemLayoutSizeFitting(viewSize,
                                                            withHorizontalFittingPriority: .required,
                                                            verticalFittingPriority: .defaultLow)
```

If you are still experiencing issues with the height of the controller not being set correctly, make sure that you got your constraints right and they are feasibly satisfiable.

In case if you are looking for into more details I've added demonstrated [Example](https://github.com/nugmanoff/DropdownTransition/tree/master/DropdownTransitionExample) to the repo.

## Support

If you have any questions regarding the library, found a bug or want to contribute, please open an [issue on GitHub](https://github.com/nugmanoff/DropdownTransition/issues/new).

Author of the project is [@nugmanoff](https://github.com/nugmanoff)

This project is licensed under [MIT License](/LICENSE)
