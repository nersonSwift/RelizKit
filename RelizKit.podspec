
Pod::Spec.new do |spec|

  spec.name         = "RelizKit"
  spec.version      = "0.0.7"
  spec.summary      = "Small example to test code sharing."
  spec.description  = "Small example to test code sharing via cocoapods."	
  
  spec.homepage     = "https://github.com/nersonSwift/RelizKit"

  spec.license      = "MIT"
  

 

  spec.author       = { "Angel-senpai" => "daniil.murygin68@gmail.com", "nersonSwift" => "aleksandrsenin@icloud.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/nersonSwift/RelizKit.git", :tag => "0.0.7" }

  # spec.source_files  = "RelizKit/**/*"
  spec.exclude_files = "RelizKit/**/*.plist"
  spec.swift_version = '5.3'
  spec.ios.deployment_target  = '13.0'

  spec.requires_arc = true

  spec.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    core.source_files   = 'RelizKit/Core/**/*'
    core.dependency 'MyLibrary/RZUIKit'
  end

  s.subspec 'RZUIKit' do |uikit|
    uikit.source_files = 'RelizKit/RZUIKit/**/*'
    
  end

end