Pod::Spec.new do |spec|
  spec.name         = "Discoverer"
  spec.version      = "0.0.2"
  spec.summary      = "Discoverer a lightweight, multiplatform dependenct injection tool written in pure Swift."
  spec.description = <<-DESC
  Discoverer a lightweight, multiplatform dependenct injection tool written in pure Swift that implements Service Locator pattern.
  DESC
  spec.homepage     = "https://github.com/lewandowskit93/Discoverer"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author       = { "Tomasz Lewandowski" => "tomasz.t.lewandowski@gmail.com" }
  spec.source       = { :git => "https://github.com/lewandowskit93/Discoverer.git", :tag => "#{spec.version}" }
  spec.source_files  = "Discoverer/**/*.swift"
  spec.swift_versions = "5.1"
  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.10'
  spec.tvos.deployment_target = '9.0'
  spec.watchos.deployment_target = '2.0'
end