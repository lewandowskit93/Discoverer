Injector is a lightweight, multiplatform dependency injection utility written in pure Swift.

## Requirements

### Development
Project uses following tools for development
1. [XCodeGen](https://github.com/yonaskolb/XcodeGen)
2. [Cocoapods](https://cocoapods.org)
3. [SwiftLint](https://github.com/realm/SwiftLint)

## Installation

To get started with the **Injector** you first have to decide how you will integrate it with your project. Injector supports following tools:

### Cocoapods

To install Injector using Cocoapods go through following steps:

1. Add the following entry in your **Podfile**:
```
pod 'Injector'
```
2. Then run `pod install`.


### Carthage

To install Injector using Carthage go through following steps:

1. Add the following entry to your **Cartfile**

```
github "lewandowskit93/Injector"
```

2. Then run ```carthage update```

### Swift Package Manager

To install Injector using **Swift Package Manager** go through following steps:

1. Add following package dependency in you **Package.swift** ``` .package(url: "https://github.com/lewandowskit93/Injector.git", from: "0.0.1") ```
2. Add following target dependency in your **Package.swift** ``` dependencies: ["Injector"]) ```

For instance this is how it might look like:
```swift
import PackageDescription

let package = Package(
    name: "YourLibrary",
    products: [
        .library(
            name: "YourLibrary",
            targets: ["YourLibrary"])
    ],
    dependencies: [
        .package(url: "https://github.com/lewandowskit93/Injector.git", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "YourLibrary",
            dependencies: ["Injector"])
    ]
)
```

## Overview

Here is a quick overview of functionalities and concepts used in **Injector**.

### Injection

**Injection** is an enum which represents single Injection. It can be one of:
- **Singleton** - returns same instance everytime e.g.: ```swift Injectable<PFoo>.singleton(Foo()) ```
- **LazySingleton** - if there is no instance it uses factory to create one, then it returns this instance everytime e.g.: ```swift Injectable<PFoo>.lazySingleton(nil, { Foo() }) ```
- **Factory** - returns new instance everytime e.g.: ```swift Injectable<PFoo>.factory({ Foo() }) ```

### Injector

**Injector** is a manages injected services. It grants access to the service by providing:
- subscript - returning service as optional (nil if not registered) e.g.: ```swift injector[PFoo.self]```
- getter - returning service and throwing error if not registered e.g.: ```swift injector.get(PFoo.self)```

### Injected
**Injected** is a property wrapper that marks a property as injected with the service provided by given Injector.
Example usage:
```swift
@Injected(injector: Environment.services) var foo: PFoo
```

## Example

Given the environment
```swift
struct Environment {
    static var services: Injector = Injector()
    static var repositories: Injector = Injector()
}
```

We could define following services and repositories: 
```swift
protocol PServiceA {
    func foo()
}

class ServiceA: PServiceA {
    func foo() {
        print("Service A")
    }
}

protocol PRepositoryB {
    func foo() -> String
}

class RepositoryB: PRepositoryB {
    func foo() -> String {
        return "foo"
    }
}
```

Then configure the injector as follows
```
struct Configurator {
    static func configure(injector: Injector) throws {
        _ = try? Environment.repositories
            .register(as: PRepositoryB.self, injectable: .singleton(RepositoryB()))
        _ = try? Environment.services
            .register(as: PServiceA.self, injectable: .factory({ ServiceA() }))
    }
}
```

And inject dependencies into ViewModel:
```swift
struct FooViewModel {
    @Injected(injector: Environment.services) var serviceA: PServiceA
    @Injected(injector: Environment.repositories) var repositoryB: PRepositoryB
}
```

For more detailed example please see the source code.

## Contribution

Project is created and maintained by **Tomasz Lewandowski**.

If you created some new feature or fixed a bug you can create a pull request. Please feel free to submit your feature requests if you have any.

## License

Injector is released under an MIT license. See [License.md](LICENSE.md) for more information.
