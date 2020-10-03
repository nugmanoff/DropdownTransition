Pod::Spec.new do |s|
  s.name             = 'DropdownTransition'
  s.version          = '1.0.0'
  s.summary          = 'Simplistic dropdown transition in Swift.'
  s.description      = 'Core component framework where all network related code reside.'
  s.homepage         = 'https://github.com/nugmanoff/DropdownTransition'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'a.nugmanoff@gmail.com' => 'a.nugmanoff@gmail.com' }
  s.source           = { :git => 'https://github.com/nugmanoff/DropdownTransition.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.ios.frameworks = 'Foundation', 'UIKit'
  s.ios.source_files = 'DropdownTransition/*.swift'
  s.swift_version = '5.0'
end
