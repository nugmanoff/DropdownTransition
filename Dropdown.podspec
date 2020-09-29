
Pod::Spec.new do |s|
  s.name = "Dropdown"
  s.summary = "Simplistic dropdown transition in Swift"
  s.version = "1.0.0"
  s.homepage = "https://github.com/nugmanoff/Dropdown"
  s.license = 'MIT'
  s.author = { "Aidar Nugmanoff" => "a.nugmanoff@gmail.com" }
  s.source = { :git => "https://github.com/nugmanoff/Dropdown.git", :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.ios.source_files = 'Sources/**/*'
  s.ios.frameworks = 'UIKit'
  s.swift_version = '5.0'
end
