
Pod::Spec.new do |spec|

  spec.name         = "RelizKit"
  spec.version      = "1.5.8"
  spec.summary      = "Small example to test code sharing."
  spec.description  = "Small example to test code sharing via cocoapods."	
  
  spec.homepage     = "https://github.com/nersonSwift/RelizKit"

  spec.license      = "MIT"
  

 

  spec.author       = { "Angel-senpai" => "daniil.murygin68@gmail.com", "nersonSwift" => "aleksandrsenin@icloud.com" }
 
  spec.source       = { :git => "https://github.com/nersonSwift/RelizKit.git", :tag => "1.5.8" }

  spec.source_files  = 'RelizKit/Core/**/*'
  spec.exclude_files = "RelizKit/**/*.plist"
  spec.swift_version = '5.3'
  spec.ios.deployment_target  = '13.0'

  spec.requires_arc = true

  spec.default_subspec = 'Core'

  spec.subspec 'Core' do |core|
    core.dependency 'RelizKit/RZUIKit'
    core.dependency 'RelizKit/RZStoreKit'
    core.dependency 'RelizKit/RZEvent'
  end

  spec.subspec 'RZUIKit' do |uikit|
    uikit.dependency 'RelizKit/RZViewBuilder'
    uikit.dependency 'RelizKit/RZScreensKit'
  end

  spec.subspec 'RZViewBuilder' do |viewbuilder|
    viewbuilder.source_files = 'RZUIKit/RZViewBuilder/**/*'
    viewbuilder.dependency 'RelizKit/RZDarkModeKit'
    viewbuilder.dependency "SVGKit"
  end

  spec.subspec 'RZScreensKit' do |screens|
    screens.source_files = 'RZUIKit/RZScreensKit/**/*'
    
  end

  spec.subspec 'RZDarkModeKit' do |darkmodekit|
    viewbuilder.dependency "RZDarkModeKit"
  end

  spec.subspec 'RZStoreKit' do |storekit|
    storekit.source_files = 'RZStoreKit/**/*'
    storekit.dependency "SwiftyStoreKit"
  end

  spec.subspec 'RZEvent' do |event|
    event.source_files = 'RZEvent/**/*'
  end

end