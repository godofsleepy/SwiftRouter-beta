# SwiftRouter (Beta)

## Installing SwiftRouter

### Swift Package Manager

To install SwiftRouter using [Swift Package Manager](https://github.com/apple/swift-package-manager) you can follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for this repo with the current version:

1. In Xcode, select “File” → “Add Packages...”
1. Enter https://github.com/godofsleepy/SwiftRouter-beta.git

or you can add the following dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/godofsleepy/SwiftRouter-beta.git", from: "0.0.1")
```
## Introduction

#### What is SwiftRouter?

Is a Swift package that streamlines navigation in SwiftUI applications. It offers named routing, manages backstack navigation, and supports dynamic data passing between views. Enhance your app’s navigation flow with SwiftRouter’s intuitive and powerful solutions.

#### Why SwiftRouter?

`SwiftRouter` enhances SwiftUI's `NavigationStack` by providing built-in functions for named routes, dynamic data passing, backstack management, and the ability to change the root view (e.g., transitioning from a splash screen to the main screen). It streamlines complex navigation logic, making your app development more efficient and stress-free.

## Setup and Usage

1. **Import `SwiftRouter`:** Start by importing `SwiftRouter` into your `App`.

2. **Declare Views Based on `router.path`:** Define your views in the `NavigationRouter` based on the `route.path`. This allows you to dynamically render different views depending on the current navigation path.

3. **Set the Initial Route:** Use the `rootPath` parameter to set the initial route when your app launches.

```swift
import SwiftUI
import SwiftRouter

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationRouter(rootPath: Route(path: "/")) { route in
                switch route.path {
                case "/main":
                    MainView(id: route.id)
                default:
                    SplashView(id: route.id)
                }
            }
        }
    }
}
```

### Navigation

1. **Import `SwiftRouter`:** Start by importing `SwiftRouter` in your view.

2. **Set Route ID:** Declare an `id` for your route, which will be passed from your app's setup (see the `App` example).

3. **Declare Router Environment Object:** Use `@EnvironmentObject` to inject the `Router` into your view, enabling navigation functionality.

4. **Navigate Using the Router:** You can now navigate between views by calling `router.push(id, "/your-path")`.

```swift
import SwiftRouter

struct SplashView: View {
    @EnvironmentObject var router: Router
    
    let id: UUID
    
    var body: some View {
        Button(action: {
            router.push(id, "/main")
        }) {
            Text("Move to new screen")
        }
    }
}
```

### Navigation Options

```swift
// Navigate to a new screen
router.push(id, "path-name")

// Navigate to a new screen with parameters and handle the result when returning
router.push(id, "path-name", param: ["data": true]) { result in
    // Handle the result here
}

// Navigate to a new screen and replace the current screen
router.pushReplace(id, "path-name")

// Go back to the previous screen, similar to dismiss()
router.pop()

// Go back to the previous screen and return data
router.pop(result: Color.red)
```
### Full Example 

you can see here for full example  [Example Code](https://github.com/godofsleepy/SwiftRouter-beta/tree/main/Example). 

# To-Do List

As this package is still in development, we welcome suggestions and feedback. Feel free to open a pull request or fork the repository to contribute.

## Completed Features
- [x] Named navigation
- [x] Navigation with data
- [x] Navigation to the previous screen with data
- [x] Changeable root

## Upcoming Enhancements
- [ ] Simplified router creation (without `@EnvironmentObject` or `Id`)
- [ ] Support for multiple `NavigationRouter` instances
- [ ] Dynamic navigation to previous screen / Pop Until (Coming Soon)
- [ ] Unit Testing
- [ ] Modularization & Deep Link Example


# Contact

