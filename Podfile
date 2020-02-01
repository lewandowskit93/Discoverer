# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
project 'Injector.xcodeproj'
 
use_frameworks!

target 'Example' do
  platform :macos, '10.10'
  pod 'SwiftLint'
end

target 'Injector_macOS' do
  platform :macos, '10.10'
  pod 'SwiftLint'

  # Pods for Injector

  target 'InjectorTests_macOS' do
    # Pods for testing
  	inherit! :search_paths
  end

end

target 'Injector_iOS' do
  platform :ios, '8.0'
  pod 'SwiftLint'

  # Pods for Injector

  target 'InjectorTests_iOS' do
    # Pods for testing
    inherit! :search_paths
  end

end

target 'Injector_tvOS' do
  platform :tvos, '10.10'
  pod 'SwiftLint'

  # Pods for Injector

  target 'InjectorTests_tvOS' do
    # Pods for testing
    inherit! :search_paths
  end

end
