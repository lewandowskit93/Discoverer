[![Build Status](https://travis-ci.org/lewandowskit93/Discoverer.svg?branch=master)](https://travis-ci.org/lewandowskit93/Discoverer)
[![codecov](https://codecov.io/gh/lewandowskit93/Discoverer/branch/master/graph/badge.svg)](https://codecov.io/gh/lewandowskit93/Discoverer)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods](https://img.shields.io/cocoapods/v/Discoverer.svg?style=flat)](https://cocoapods.org/pods/Discoverer)
[![Platform](https://img.shields.io/cocoapods/p/Discoverer.svg?style=flat)](https://cocoapods.org/pods/Discoverer)
[![Platform](https://img.shields.io/badge/Platform-linux-brightgreen.svg)](#)
[![License](https://img.shields.io/cocoapods/l/Discoverer.svg?style=flat)](https://cocoapods.org/pods/Discoverer)

Discoverer is a lightweight, multiplatform dependency injection utility written in pure Swift.

## Requirements

### Development
Project uses following tools for development
1. [XCodeGen](https://github.com/yonaskolb/XcodeGen)
2. [Cocoapods](https://cocoapods.org)
3. [SwiftLint](https://github.com/realm/SwiftLint)

## Installation

To get started with the **Discoverer** you first have to decide how you will integrate it with your project. Discoverer supports following tools:

### Cocoapods

To install Discoverer using Cocoapods go through following steps:

1. Add the following entry in your **Podfile**:
```
pod 'Discoverer'
```
2. Then run `pod install`.


### Carthage

To install Discoverer using Carthage go through following steps:

1. Add the following entry to your **Cartfile**

```
github "lewandowskit93/Discoverer"
```

2. Then run ```carthage update```

### Swift Package Manager

To install Discoverer using **Swift Package Manager** go through following steps:

1. Add following package dependency in you **Package.swift** ``` .package(url: "https://github.com/lewandowskit93/Discoverer.git", from: "0.0.3") ```
2. Add following target dependency in your **Package.swift** ``` dependencies: ["Discoverer"]) ```

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
        .package(url: "https://github.com/lewandowskit93/Discoverer.git", from: "0.0.3")
    ],
    targets: [
        .target(
            name: "YourLibrary",
            dependencies: ["Discoverer"])
    ]
)
```

## Overview

Here is a quick overview of functionalities and concepts used in **Discoverer**.

### Injection

**Injection** is an enum which represents single Injection. It can be one of:
- **Singleton** - returns same instance everytime e.g.: 
```swift
Injectable<PFoo>.singleton(Foo())
```
- **LazySingleton** - if there is no instance it uses factory to create one, then it returns this instance everytime e.g.: 
```swift
Injectable<PFoo>.lazySingleton(nil, { Foo() })
```
- **Factory** - returns new instance everytime e.g.: 
```swift
Injectable<PFoo>.factory({ Foo() })
```

### Injector

**Injector** manages injected services. It grants access to the service by providing:
- subscript - returning service as optional (nil if not registered) e.g.:
```swift
injector[PFoo.self]
```
- getter - returning service and throwing error if not registered e.g.: 
```swift
injector.get(PFoo.self)
```

### Injected
**Injected** is a property wrapper that marks a property as injected with the service provided by given Injector.
Example usage:
```swift
@Injected var foo: PFoo
```
Injected also allows you to specify which container to use as follows:
```swift
@Injected(injector: Environment.services) var serviceA: PServiceA
```
### Registered
**Registered** is a property wrapper that marks an injection as registered in given Injector.
Example usage:
```swift
@Registered
var serviceAInjection = Injection<PServiceA>.singleton(ServiceA())
```
Registered also allows you to specify which container to use as follows:
```swift
@Registered(inInjector: Environment.services)
var serviceAInjection = Injection<PServiceA>.singleton(ServiceA())
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

Then configure the injector as follows:
```swift
struct Configurator {
    static func configure(repositories: Injector, services: Injector) throws {
        _ = try? repositories
            .register(as: PRepositoryB.self, injectable: .singleton(RepositoryB()))
        _ = try? services
            .register(as: PServiceA.self, injectable: .factory({ ServiceA() }))
    }
}
```
or:
```swift
struct Configurator {
    @Registered(inInjector: Environment.repositories)
    var repositoryBInjection = Injection<PRepositoryB>.factory({ RepositoryB() })

    @Registered(inInjector: Environment.services)
    var serviceAInjection = Injection<PServiceA>.singleton(ServiceA())
}
```
*The second approach requires creating an instance of Configurator, so that injections are registered.*

Then inject dependencies into ViewModel:
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

Discoverer is released under an MIT license. See [License.md](LICENSE.md) for more information.
